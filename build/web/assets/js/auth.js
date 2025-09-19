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
  const switchButtons = document.querySelectorAll(".switch-form-btn");
  const slidingBg = document.querySelector(".sliding-bg");
  const loginContainer = document.querySelector(".login-container");
  const registerContainer = document.querySelector(".register-container");

  switchButtons.forEach((button) => {
    button.addEventListener("click", () => {
      toggleForms();
    });
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

  // Re-initialize switch button
  const newSwitchButton = document.querySelector(
    ".welcome-content .switch-form-btn"
  );
  if (newSwitchButton) {
    newSwitchButton.addEventListener("click", toggleForms);
  }
}

/* ===================================================================
   PASSWORD TOGGLE FUNCTIONALITY
   =================================================================== */

function initializePasswordToggle() {
  const passwordToggles = document.querySelectorAll(".password-toggle");

  passwordToggles.forEach((toggle) => {
    toggle.addEventListener("click", function () {
      const input = this.previousElementSibling;
      if (!input) return;

      if (input.type === "password") {
        input.type = "text";
        this.innerHTML = '<i class="fas fa-eye-slash"></i>';
      } else {
        input.type = "password";
        this.innerHTML = '<i class="fas fa-eye"></i>';
      }
    });
  });
}

/* ===================================================================
   FORM VALIDATION
   =================================================================== */

function initializeFormValidation() {
  const forms = document.querySelectorAll(".auth-form form");

  forms.forEach((form) => {
    form.addEventListener("submit", handleFormSubmit);

    const inputs = form.querySelectorAll("input");
    inputs.forEach((input) => {
      input.addEventListener("blur", () => validateField(input));
      input.addEventListener("input", () => clearFieldError(input));
    });
  });
}

function handleFormSubmit(e) {
  e.preventDefault();

  const form = e.target;
  const submitBtn = form.querySelector(".submit-btn");
  const inputs = form.querySelectorAll("input[required]");

  let isValid = true;

  // Validate all required fields
  inputs.forEach((input) => {
    if (!validateField(input)) {
      isValid = false;
    }
  });

  if (isValid) {
    // Add loading state
    submitBtn.classList.add("loading");
    submitBtn.textContent = "Đang xử lý...";

    // Simulate API call
    setTimeout(() => {
      // Remove loading state
      submitBtn.classList.remove("loading");

      if (form.classList.contains("login-form")) {
        submitBtn.textContent = "Đăng nhập";
        handleLoginSubmit(form);
      } else {
        submitBtn.textContent = "Đăng ký";
        handleRegisterSubmit(form);
      }
    }, 2000);
  }
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

/* ===================================================================
   FORM SUBMISSION HANDLERS
   =================================================================== */

function handleLoginSubmit(form) {
  const formData = new FormData(form);
  const username = formData.get("username");
  const password = formData.get("password");

  // Here you would typically send data to your server
  console.log("Login attempt:", { username, password });

  // Simulate success/error
  if (username && password) {
    showAuthMessage("Đăng nhập thành công!", "success");
    // Redirect after success
    setTimeout(() => {
      window.location.href = "home.jsp";
    }, 1500);
  } else {
    showAuthMessage("Tên đăng nhập hoặc mật khẩu không đúng!", "error");
  }
}

function handleRegisterSubmit(form) {
  const formData = new FormData(form);
  const data = Object.fromEntries(formData.entries());

  // Here you would typically send data to your server
  console.log("Registration attempt:", data);

  // Simulate success
  showAuthMessage("Đăng ký thành công! Vui lòng đăng nhập.", "success");

  // Switch to login form after successful registration
  setTimeout(() => {
    toggleForms();
  }, 2000);
}

/* ===================================================================
   SOCIAL LOGIN
   =================================================================== */

function initializeSocialLogin() {
  const socialButtons = document.querySelectorAll(".social-btn");

  socialButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();

      const provider = this.classList.contains("facebook")
        ? "Facebook"
        : this.classList.contains("google")
        ? "Google"
        : this.classList.contains("twitter")
        ? "Twitter"
        : "Unknown";

      showAuthMessage(
        `Đăng nhập với ${provider} đang được phát triển...`,
        "info"
      );
    });
  });
}

/* ===================================================================
   AUTHENTICATION FORM INITIALIZATION
   =================================================================== */

function initializeAuthForms() {
  // Add form validation styling
  addAuthStyles();

  // Initialize remember me functionality
  initializeRememberMe();

  // Initialize forgot password
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
    `;
  document.head.appendChild(styles);
}

function initializeRememberMe() {
  const rememberCheckbox = document.querySelector('input[name="remember"]');
  if (!rememberCheckbox) return;

  rememberCheckbox.addEventListener("change", function () {
    if (this.checked) {
      console.log("Remember me enabled");
    } else {
      console.log("Remember me disabled");
    }
  });
}

function initializeForgotPassword() {
  const forgotPasswordLinks = document.querySelectorAll(".forgot-password a");

  forgotPasswordLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      showForgotPasswordModal();
    });
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

  document.body.appendChild(modal);

  // Close modal functionality
  const closeBtn = modal.querySelector(".close");
  closeBtn.addEventListener("click", () => {
    document.body.removeChild(modal);
  });

  modal.addEventListener("click", (e) => {
    if (e.target === modal) {
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

/* ===================================================================
   UTILITY FUNCTIONS
   =================================================================== */

function validateEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(email);
}

function validatePhone(phone) {
  const re = /^[0-9]{10,11}$/;
  return re.test(phone.replace(/\s/g, ""));
}

function showAuthMessage(message, type = "info") {
  // Remove existing messages
  const existingMessage = document.querySelector(".auth-message");
  if (existingMessage) {
    existingMessage.remove();
  }

  // Create message element
  const messageElement = document.createElement("div");
  messageElement.className = `auth-message auth-message-${type}`;
  messageElement.textContent = message;

  // Style the message
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

  // Add slide down animation
  const slideDownKeyframes = `
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

  if (!document.querySelector("#slideDownStyles")) {
    const styleSheet = document.createElement("style");
    styleSheet.id = "slideDownStyles";
    styleSheet.textContent = slideDownKeyframes;
    document.head.appendChild(styleSheet);
  }

  // Add to DOM
  document.body.appendChild(messageElement);

  // Remove after delay
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

/* ===================================================================
   KEYBOARD SHORTCUTS
   =================================================================== */

document.addEventListener("keydown", (e) => {
  // Escape key to close modals
  if (e.key === "Escape") {
    const modal = document.querySelector(".auth-modal");
    if (modal) {
      document.body.removeChild(modal);
    }
  }

  // Enter key to switch forms (when not in input)
  if (e.key === "Enter" && !e.target.matches("input, button")) {
    const switchBtn = document.querySelector(
      ".welcome-content .switch-form-btn"
    );
    if (switchBtn) {
      switchBtn.click();
    }
  }
});
