# E-Commerce Backend API (Node.js + Express + MongoDB)

  

**Repository**: [https://github.com/sadmanrashik1/ecommerce-api-nodejs](https://github.com/sadmanrashik1/ecommerce-api-nodejs)
## Hybrid testing api (reliable+fastest)
- Local Postman Application + hosted onrender api
	- import post man collection from root of repo
	- set URL variable as : https://ecommerce-api-nodejs-2gmv.onrender.com/api/v1
	- to get verify email url login to ethereal
		- ETHEREAL_USER=michele.willms@ethereal.email
		- ETHEREAL_PASS=pXvffTf9n9frwpZnQj
		- Then use "verificationToken","email" in postman ->VerifyEmail route
		- (email routes dnt work at render free tier -only for documentation purposes)
	- admin user credentials
		- sadmanadmin@gmail.com
		- password: secret
	-  normal user credentials
		- sadmanuser@gmail.com
		- password: secret



## Local Setup Steps

1. Clone repo

```bash

git clone https://github.com/sadmanrashik1/ecommerce-api-nodejs.git

cd ecommerce-api-nodejs

```

2. Install dependencies

```bash

npm install

```

3. Create .env file

```bash

MONGO_URL=

JWT_SECRET=

JWT_LIFETIME=

ETHEREAL_USER=

ETHEREAL_PASS=

```

  

4. Run

```bash

npm start

```

5. Import postman collection

```bash

Test

```

  
  
  

## Overview

Full-featured e-commerce backend API with user authentication, role-based access, product management, reviews, and orders.

  

### Key Features

- JWT authentication with access + refresh tokens (httpOnly cookies)

- Email verification & password reset

- Admin/user roles

- Product CRUD + image upload (local for demo)

- Reviews (one per user per product)

- Order creation & management

  

### Technologies

- Runtime: Node.js

- Framework: Express.js

- Database: MongoDB with Mongoose

- Authentication: JWT (JSON Web Tokens), bcrypt.js

- File Upload: Express-fileupload, Cloudinary

- Email: Nodemailer

- Payments: Stripe API fake endpoint

- Validation: Express-validator

- Security: Helmet, CORS, express-rate-limit

  
  
  
  

## Models Schema

**User** 
name, email (unique), password, role ('user'/'admin'), verificationToken, isVerified, verified, passwordToken, passwordTokenExpirationDate

  

**Product**

name, price, description, image (default provided), category (office/kitchen/bedroom), company (ikea/liddy/marcos), colors[], featured, freeShipping, inventory, averageRating, numOfReviews, user (ref User)

  

**Review**

rating (1–5), title, comment, user (ref User), product (ref Product) – unique per user/product

**SingleOrderItemSchema**
name , image, price, amout, product (ref Product)
  
  

**Order**

tax, shippingFee, subtotal, total, orderItems[SingleOrderItemSchema], status, user (ref User), clientSecret, paymentIntentId

  

**Token** (refresh token storage)

refreshToken, ip, userAgent, isValid, user (ref User)

## User Roles & Permissions

### Regular User (role: 'user')
**Can do:**
- Register / Login / Logout
- Verify email, forgot/reset password
- View/update own profile and password (`/users/showMe`, `/users/updateUser`, `/users/updateUserPassword`)
- View all products and single product details
- Create/read/update/delete own reviews(perproduct single review per user)
- Create orders
- View own orders (`/orders/showAllMyOrders`)

**Cannot do:**
- Create/update/delete products
- Upload product images
- View all users or all orders
- Access any admin-only routes

### Admin (role: 'admin')
**Can do everything a regular user can +:**
- Create, update, delete products
- Upload product images
- View all users (`/users`)
- View all orders (`/orders`)
- Update order status (`PATCH /orders/:id`)

**Note:** The first registered account automatically becomes admin.

  

## API Endpoints

  

### Auth (`/auth`)

- POST /register – Register

- POST /verify-email – Verify email

- POST /login – Login (sets cookies)

- POST /forgot-password – Send reset email

- POST /reset-password – Reset password

- DELETE /logout – Logout (clears cookies)

  

### Users (`/users`)

- GET / – All users (admin)

- GET /:id – Single user

- GET /showMe – Current user

- PATCH /updateUser – Update profile

- PATCH /updateUserPassword – Update password

  

### Products (`/products`)

- GET / – All products

- GET /:id – Single product

- POST / – Create (admin)

- PATCH /:id – Update (admin)

- DELETE /:id – Delete (admin)

- POST /uploadImage – Upload image (admin)

- GET /:id/reviews – Product reviews

  

### Reviews (`/reviews`)

- GET / – All reviews

- POST / – Create review

- GET /:id – Single review

- PATCH /:id – Update (owner)

- DELETE /:id – Delete (owner)

  

### Orders (`/orders`)

- GET / – All orders (admin)

- POST / – Create order

- GET /showAllMyOrders – My orders

- GET /:id – Single order

- PATCH /:id – Update (admin)

  

## Notes

  

- Image upload: local (public/uploads) for demo – use Cloudinary/S3 in production.

- Email: Ethereal fake SMTP (update in .env ).

- Testing: Use Postman : Import collection
