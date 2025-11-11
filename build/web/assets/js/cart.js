(function () {
    // formatter for VND without decimals
    const fmt = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND', maximumFractionDigits: 0});

    function parseNumber(v) {
        // v expected to be number or string; ensure numeric
        if (v == null || v === '')
            return 0;
        return Number(v);
    }

    function recomputeTotal() {
        const checkboxes = document.querySelectorAll('.select-item');
        let total = 0;
        checkboxes.forEach(cb => {
            if (cb.checked) {
                // data-subtotal kept as plain number (server-side) or updated by JS
                total += parseNumber(cb.getAttribute('data-subtotal'));
            }
        });
        document.getElementById('totalAmount').textContent = fmt.format(total);
        document.getElementById('amount').value = total;
    }

    // update subtotal cell when qty changes (and update checkbox data-subtotal if checked)
    function updateItemSubtotal(itemId) {
        const row = document.querySelector('tr[data-item-id="' + itemId + '"]');
        if (!row)
            return;
        const qtyInput = row.querySelector('input[name="qty_' + itemId + '"]');
        const unitPriceText = row.querySelector('td:nth-child(5)').textContent || '0';
        // Fallback: we'll read numeric unit price from a data attribute instead of text is more robust;
        // but here we parse displayed price by removing non-digit chars.
        let unitPrice = 0;
        // Try to find unit price value in a data attribute (if you populate it server-side, add data-unit-price)
        const unitPriceAttr = row.getAttribute('data-unit-price');
        if (unitPriceAttr) {
            unitPrice = Number(unitPriceAttr);
        } else {
            // parse from formatted text
            unitPrice = Number(unitPriceText.replace(/[^\d]/g, '')) || 0;
        }

        const qty = Math.max(1, parseInt(qtyInput.value) || 1);
        const subtotal = unitPrice * qty;
        // update visible subtotal formatted
        const subEl = row.querySelector('.item-subtotal');
        if (subEl)
            subEl.textContent = fmt.format(subtotal);
        // update checkbox data-subtotal
        const cb = row.querySelector('.select-item');
        if (cb)
            cb.setAttribute('data-subtotal', subtotal);
        // recompute overall total if checkbox is checked
        recomputeTotal();
    }

    // event delegation for +/- and qty change
    document.addEventListener('click', function (e) {
        const target = e.target;
        if (target.matches('.btn-incr') || target.matches('.btn-decr')) {
            const itemId = target.getAttribute('data-item');
            const row = document.querySelector('tr[data-item-id="' + itemId + '"]');
            if (!row)
                return;
            const input = row.querySelector('input[name="qty_' + itemId + '"]');
            let val = Math.max(1, parseInt(input.value) || 1);
            val = target.matches('.btn-incr') ? val + 1 : Math.max(1, val - 1);
            input.value = val;
            updateItemSubtotal(itemId);
            // Optionally, auto-send quantity update to server (AJAX) — omitted to keep minimal.
        }
    });

    // handle manual qty typing
    document.addEventListener('change', function (e) {
        const target = e.target;
        if (target.matches('input[type="number"].qty-input')) {
            const itemId = target.getAttribute('data-item');
            if (!itemId)
                return;
            if ((parseInt(target.value) || 0) < 1)
                target.value = 1;
            updateItemSubtotal(itemId);
        }
    });

    // checkbox change -> recompute
    document.addEventListener('change', function (e) {
        const t = e.target;
        if (t.matches('.select-item')) {
            recomputeTotal();
        } else if (t.matches('#selectAll')) {
            const checked = t.checked;
            document.querySelectorAll('.select-item').forEach(cb => cb.checked = checked);
            recomputeTotal();
        }
    });

    // when user submits checkout form, attach selected item ids as form fields
    document.getElementById('checkoutForm')?.addEventListener('submit', function (e) {
        // if the submission is to clear cart (btnClear) we should allow it
        // Determine which button triggered submit: check activeElement or submitter (modern browsers)
        const submitter = document.activeElement;
        if (submitter && submitter.id === 'btnClear') {
            // allow clear to proceed (server handles clearing)
            return;
        }

        // collect checked items
        const selected = Array.from(document.querySelectorAll('.select-item:checked')).map(cb => cb.getAttribute('data-id'));
        if (selected.length === 0) {
            e.preventDefault();
            alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán.');
            return;
        }

        // remove any previously added hidden input for selectedItem
        document.querySelectorAll('input[name="selectedItemId"]').forEach(n => n.remove());
        // append selected item ids as hidden inputs
        selected.forEach(id => {
            const hid = document.createElement('input');
            hid.type = 'hidden';
            hid.name = 'selectedItemId';
            hid.value = id;
            this.appendChild(hid);
        });

        // also append current quantities so server can re-validate
        // remove previous qty_* hidden if any, then append current ones
        document.querySelectorAll('input[name^="post_qty_"]').forEach(n => n.remove());
        document.querySelectorAll('input.qty-input').forEach(inp => {
            const hid = document.createElement('input');
            hid.type = 'hidden';
            hid.name = 'post_qty_' + inp.getAttribute('data-item');
            hid.value = inp.value;
            hid.name = 'post_qty_' + inp.getAttribute('data-item');
            hid.setAttribute('name', 'post_qty_' + inp.getAttribute('data-item'));
            this.appendChild(hid);
        });

        // It's ok to let the form submit normally; server should revalidate prices & stock.
    });

    // Initialize: ensure totals reflect any pre-checked items (if server pre-checks)
    recomputeTotal();

})();