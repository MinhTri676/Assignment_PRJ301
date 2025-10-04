/* ===================================================================
   MERCURION E-COMMERCE - AUTHENTICATION JAVASCRIPT
   Version: 2.0
   =================================================================== */

// Initialize authentication functionality when DOM is loaded
document.addEventListener("DOMContentLoaded", function () {
  initializeAuthForms();
  initializePasswordToggle();
  initializeFormSwitching();
  initializeFormValidation();
  initializeSocialLogin();
});

/* ===================================================================
   FORM SWITCHING FUNCTIONALITY
   =================================================================== */

let isLoginForm = true;

function initializeFormSwitching() {
  // Sử dụng event delegation thay vì bind trực tiếp
  document.addEventListener("click", function (e) {
    if (e.target.classList.contains("switch-form-btn")) {
      e.preventDefault();
      toggleForms();
    }
  });
}

function toggleForms() {
  const slidingBg = document.querySelector(".sliding-bg");
  const loginContainer = document.querySelector(".login-container");
  const registerContainer = document.querySelector(".register-container");
  const welcomeContent = document.querySelector(".welcome-content");

  if (!slidingBg || !loginContainer || !registerContainer) return;

  isLoginForm = !isLoginForm;

  if (isLoginForm) {
    // Switch to login form
    slidingBg.classList.remove("slide-right");
    loginContainer.classList.add("active");
    registerContainer.classList.remove("active");

    if (welcomeContent) {
      welcomeContent.innerHTML = `
        <h2>Chào mừng trở lại!</h2>
        <p>Đăng nhập để truy cập tài khoản của bạn và tiếp tục mua sắm với những ưu đãi độc quyền.</p>
        <button class="btn switch-form-btn" type="button">Tạo tài khoản mới</button>
      `;
    }
  } else {
    // Switch to register form
    slidingBg.classList.add("slide-right");
    loginContainer.classList.remove("active");
    registerContainer.classList.add("active");

    if (welcomeContent) {
      welcomeContent.innerHTML = `
        <h2>Xin chào!</h2>
        <p>Tạo tài khoản để khám phá thế giới mua sắm với hàng ngàn sản phẩm chất lượng và ưu đãi hấp dẫn.</p>
        <button class="btn switch-form-btn" type="button">Đăng nhập</button>
      `;
    }
  }

  console.log("Form switched to:", isLoginForm ? "Login" : "Register");
}

// Phần còn lại của code giữ nguyên...

function initializePasswordToggle() {
  document.addEventListener("click", function (e) {
    if (e.target.closest(".password-toggle")) {
      e.preventDefault();
      const button = e.target.closest(".password-toggle");
      const input = button.parentElement.querySelector("input");
      const icon = button.querySelector("i");

      if (input.type === "password") {
        input.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash");
      } else {
        input.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye");
      }
    }
  });
}

function initializeFormValidation() {
  // Validation logic
  document.addEventListener(
    "blur",
    function (e) {
      if (
        e.target.matches(
          'input[required], input[type="email"], input[type="password"]'
        )
      ) {
        validateField(e.target);
      }
    },
    true
  );

  document.addEventListener("input", function (e) {
    if (e.target.matches("input")) {
      clearFieldError(e.target);
    }
  });

  // Form submission
  document.addEventListener("submit", function (e) {
    const form = e.target;
    if (
      form.classList.contains("login-form") ||
      form.classList.contains("register-form")
    ) {
      e.preventDefault();

      const inputs = form.querySelectorAll("input[required]");
      let isValid = true;

      inputs.forEach((input) => {
        if (!validateField(input)) {
          isValid = false;
        }
      });

      if (isValid) {
        if (form.classList.contains("login-form")) {
          handleLoginSubmit(form);
        } else {
          handleRegisterSubmit(form);
        }
      }
    }
  });
}

function validateField(input) {
  const value = input.value.trim();
  const type = input.type;
  const name = input.name;

  let isValid = true;
  let errorMessage = "";

  // Required field validation
  if (input.required && !value) {
    isValid = false;
    errorMessage = "Trường này là bắt buộc";
  }
  // Email validation
  else if (type === "email" && value && !validateEmail(value)) {
    isValid = false;
    errorMessage = "Email không hợp lệ";
  }
  // Password validation
  else if (type === "password" && value && value.length < 6) {
    isValid = false;
    errorMessage = "Mật khẩu phải có ít nhất 6 ký tự";
  }
  // Confirm password validation
  else if (name === "confirmPassword") {
    const password = input.form.querySelector('input[name="password"]').value;
    if (value !== password) {
      isValid = false;
      errorMessage = "Mật khẩu xác nhận không khớp";
    }
  }
  // Phone validation (if exists)
  else if (name === "phone" && value && !validatePhone(value)) {
    isValid = false;
    errorMessage = "Số điện thoại không hợp lệ";
  }

  showFieldValidation(input, isValid, errorMessage);
  return isValid;
}

function showFieldValidation(input, isValid, errorMessage) {
  const inputGroup = input.closest(".input-group");
  if (!inputGroup) return;

  // Remove existing error
  const existingError = inputGroup.querySelector(".field-error");
  if (existingError) {
    existingError.remove();
  }

  if (!isValid && errorMessage) {
    // Add error styling
    inputGroup.style.borderColor = "#dc3545";

    // Add error message
    const errorElement = document.createElement("div");
    errorElement.className = "field-error";
    errorElement.textContent = errorMessage;
    errorElement.style.cssText = `
      color: #dc3545;
      font-size: 0.8rem;
      margin-top: 5px;
      padding-left: 15px;
    `;
    inputGroup.appendChild(errorElement);
  } else {
    // Remove error styling
    inputGroup.style.borderColor = "";
  }
}

function clearFieldError(input) {
  const inputGroup = input.closest(".input-group");
  if (!inputGroup) return;

  const existingError = inputGroup.querySelector(".field-error");
  if (existingError) {
    existingError.remove();
    inputGroup.style.borderColor = "";
  }
}

function handleLoginSubmit(form) {
  const formData = new FormData(form);
  console.log("Login attempt:", Object.fromEntries(formData.entries()));

  // Submit form normally
  form.submit();
}

function handleRegisterSubmit(form) {
  const formData = new FormData(form);
  const data = Object.fromEntries(formData.entries());

  console.log("Registration attempt:", data);

  showAuthMessage("Đăng ký thành công! Vui lòng đăng nhập.", "success");

  setTimeout(() => {
    toggleForms();
  }, 2000);
}

function initializeSocialLogin() {
  document.addEventListener("click", function (e) {
    if (e.target.closest(".social-btn")) {
      e.preventDefault();
      const button = e.target.closest(".social-btn");

      const provider = button.classList.contains("facebook")
        ? "Facebook"
        : button.classList.contains("google")
        ? "Google"
        : button.classList.contains("twitter")
        ? "Twitter"
        : "Unknown";

      showAuthMessage(
        `Đăng nhập với ${provider} đang được phát triển...`,
        "info"
      );
    }
  });
}

function initializeAuthForms() {
  addAuthStyles();
  initializeRememberMe();
  initializeForgotPassword();
}

function addAuthStyles() {
  const styles = document.createElement("style");
  styles.textContent = `
    .field-error {
      animation: slideInError 0.3s ease-out;
    }
    
    @keyframes slideInError {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
    
    .input-group.error {
      border-color: #dc3545 !important;
    }
    
    .input-group.success {
      border-color: #28a745 !important;
    }
    
    .shake {
      animation: shake 0.5s ease-in-out;
    }
    
    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateX(-50%) translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
      }
    }
  `;
  document.head.appendChild(styles);
}

function initializeRememberMe() {
  document.addEventListener("change", function (e) {
    if (e.target.matches('input[name="remember"]')) {
      console.log("Remember me:", e.target.checked ? "enabled" : "disabled");
    }
  });
}

function initializeForgotPassword() {
  document.addEventListener("click", function (e) {
    if (e.target.closest(".forgot-password a")) {
      e.preventDefault();
      showForgotPasswordModal();
    }
  });
}

function showForgotPasswordModal() {
  const modal = document.createElement("div");
  modal.className = "auth-modal";
  modal.innerHTML = `
    <div class="auth-modal-content">
      <span class="close">&times;</span>
      <h3>Quên mật khẩu</h3>
      <p>Nhập email của bạn để nhận liên kết đặt lại mật khẩu.</p>
      <form class="forgot-password-form">
        <div class="input-group">
          <input type="email" placeholder="Email của bạn" required>
          <i class="fas fa-envelope"></i>
        </div>
        <button type="submit" class="submit-btn">Gửi liên kết</button>
      </form>
    </div>
  `;

  // Add modal styles
  Object.assign(modal.style, {
    position: "fixed",
    top: "0",
    left: "0",
    width: "100%",
    height: "100%",
    backgroundColor: "rgba(0,0,0,0.5)",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    zIndex: "10000",
  });

  const modalContent = modal.querySelector(".auth-modal-content");
  Object.assign(modalContent.style, {
    backgroundColor: "#fff",
    padding: "30px",
    borderRadius: "10px",
    maxWidth: "400px",
    width: "90%",
  });

  document.body.appendChild(modal);

  // Close modal functionality
  modal.addEventListener("click", function (e) {
    if (e.target === modal || e.target.classList.contains("close")) {
      document.body.removeChild(modal);
    }
  });

  // Form submission
  const form = modal.querySelector(".forgot-password-form");
  form.addEventListener("submit", function (e) {
    e.preventDefault();
    const email = this.querySelector("input").value;

    if (validateEmail(email)) {
      showAuthMessage(
        "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!",
        "success"
      );
      document.body.removeChild(modal);
    } else {
      showAuthMessage("Email không hợp lệ!", "error");
    }
  });
}

function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

function validatePhone(phone) {
  const re = /^[0-9]{10,11}$/;
  return re.test(phone.replace(/\s/g, ""));
}

function showAuthMessage(message, type = "info") {
  const existingMessage = document.querySelector(".auth-message");
  if (existingMessage) {
    existingMessage.remove();
  }

  const messageElement = document.createElement("div");
  messageElement.className = `auth-message auth-message-${type}`;
  messageElement.textContent = message;

  const colors = {
    success: {
      bg: "rgba(40, 167, 69, 0.1)",
      border: "#28a745",
      color: "#28a745",
    },
    error: {
      bg: "rgba(220, 53, 69, 0.1)",
      border: "#dc3545",
      color: "#dc3545",
    },
    info: {
      bg: "rgba(173, 101, 185, 0.1)",
      border: "#ad65b9",
      color: "#ad65b9",
    },
    warning: {
      bg: "rgba(255, 193, 7, 0.1)",
      border: "#ffc107",
      color: "#856404",
    },
  };

  const style = colors[type] || colors.info;

  Object.assign(messageElement.style, {
    position: "fixed",
    top: "20px",
    left: "50%",
    transform: "translateX(-50%)",
    padding: "15px 20px",
    borderRadius: "10px",
    background: style.bg,
    border: `1px solid ${style.border}`,
    color: style.color,
    zIndex: "10000",
    fontSize: "14px",
    fontWeight: "500",
    maxWidth: "400px",
    textAlign: "center",
    animation: "slideDown 0.3s ease-out",
  });

  document.body.appendChild(messageElement);

  setTimeout(() => {
    if (messageElement.parentNode) {
      messageElement.style.animation = "slideUp 0.3s ease-out forwards";
      setTimeout(() => {
        if (messageElement.parentNode) {
          document.body.removeChild(messageElement);
        }
      }, 300);
    }
  }, 4000);
}

// Keyboard shortcuts
document.addEventListener("keydown", (e) => {
  if (e.key === "Escape") {
    const modal = document.querySelector(".auth-modal");
    if (modal) {
      document.body.removeChild(modal);
    }
  }

  if (e.key === "Enter" && !e.target.matches("input, button")) {
    const switchBtn = document.querySelector(
      ".welcome-content .switch-form-btn"
    );
    if (switchBtn) {
      switchBtn.click();
    }
  }
});
