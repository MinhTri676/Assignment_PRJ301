<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add New Account</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.name}">
            <c:redirect url="index.jsp" />
        </c:if>
        <c:import url="headerAdmin.jsp"></c:import>
        <title>Registration Form</title>
        <div class="form">
            <div class="form-container">
                <h1>Add new account</h1>
                <form action="addAccount" method="post">
                    <div class="form-section">
                        <h2>Account</h2>
                        <div class="form-group">
                            <input type="text" name="account" required>
                        </div>
                        <div class="form-group">
                            <h2>Password</h2>
                            <input type="password" name="password" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Last name</h2>
                        <div class="form-group">
                            <input type="text" name="lastName" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>First name</h2>
                        <div class="form-group">
                            <input type="text"name="firstName" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Birth day</h2>
                        <div class="form-group">
                            <input type="date" name="birthday" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Gender</h2>
                        <div class="form-group">
                            <label>
                                <input type="radio" name="gender" value="1" required> Male
                            </label>
                            <label>
                                <input type="radio" name="gender" value="0" required> Female
                            </label>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Phone number</h2>
                        <div class="form-group">
                            <input type="tel" name="phone" required>
                        </div>
                    </div>

                    <div class="form-section">
                        <h2>Role in system</h2>
                        <div class="form-group">
                            <select name="role" required>
                                <option value="1">Administrator</option>
                                <option value="2">Manager</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="form-group">
                            <label>
                                <input value="1" type="checkbox" name="isActive"> Is active
                            </label>
                        </div>
                    </div>

                    <div class="form-section">
                        <button type="submit"><span>Submit</span></button>
                        <a href="getListAllAccount" class="cancel-btn"><span>Cancel</span></a>
                    </div>
                </form>
            </div>
        </div>
    </body>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body, html {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow-x: hidden;
        }

        body:before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.05)"/><circle cx="60" cy="30" r="1.5" fill="rgba(255,255,255,0.08)"/></svg>') repeat;
            pointer-events: none;
            z-index: 0;
        }

        .form {
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
            padding: 40px 20px;
            position: relative;
            z-index: 1;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            width: 100%;
            max-width: 800px;
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .form-container:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.1), transparent);
            transition: left 0.8s;
        }

        .form-container:hover:before {
            left: 100%;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-container h1 {
            text-align: center;
            margin-bottom: 40px;
            font-size: 2.5rem;
            color: #333;
            font-weight: 700;
            position: relative;
            z-index: 2;
        }

        .form-container h1:after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .form-section {
            margin-bottom: 25px;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .form-section:nth-child(1) { animation-delay: 0.1s; }
        .form-section:nth-child(2) { animation-delay: 0.2s; }
        .form-section:nth-child(3) { animation-delay: 0.3s; }
        .form-section:nth-child(4) { animation-delay: 0.4s; }
        .form-section:nth-child(5) { animation-delay: 0.5s; }
        .form-section:nth-child(6) { animation-delay: 0.6s; }
        .form-section:nth-child(7) { animation-delay: 0.7s; }
        .form-section:nth-child(8) { animation-delay: 0.8s; }
        .form-section:nth-child(9) { animation-delay: 0.9s; }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-section h2 {
            margin-bottom: 15px;
            font-size: 1.2rem;
            color: #667eea;
            font-weight: 600;
            position: relative;
            padding-left: 20px;
        }

        .form-section h2:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 20px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .form-group {
            margin-bottom: 15px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
            transition: color 0.3s ease;
        }

        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="tel"],
        .form-group input[type="date"],
        .form-group select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e8ed;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
            color: #333;
        }

        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus,
        .form-group input[type="tel"]:focus,
        .form-group input[type="date"]:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 20px rgba(102, 126, 234, 0.2);
            transform: translateY(-2px);
        }

        .form-group input[type="radio"],
        .form-group input[type="checkbox"] {
            margin-right: 10px;
            transform: scale(1.2);
            accent-color: #667eea;
        }


        .form-section button {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-right: 15px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .form-section button:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #764ba2, #667eea);
            transition: left 0.3s ease;
        }

        .form-section button:hover:before {
            left: 0;
        }

        .form-section button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .form-section button span {
            position: relative;
            z-index: 1;
        }

        .cancel-btn {
            background: linear-gradient(45deg, #6c757d, #495057);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 25px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .cancel-btn:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, #495057, #6c757d);
            transition: left 0.3s ease;
        }

        .cancel-btn:hover:before {
            left: 0;
        }

        .cancel-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.4);
        }

        .cancel-btn span {
            position: relative;
            z-index: 1;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
                margin: 20px;
            }

            .form-container h1 {
                font-size: 2rem;
            }

            .form-section button,
            .cancel-btn {
                width: 100%;
                margin-bottom: 10px;
                margin-right: 0;
            }
        }

        @media (max-width: 480px) {
            .form {
                padding: 20px 10px;
            }

            .form-container {
                padding: 25px 15px;
            }

            .form-container h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</html>


