# Wrapper function for all requests
COOKIE_JAR="cookies.txt"
LOG_FILE="outputLog.txt"

api_request() {
	local BASE_URL="$1"
	local method="$2"      # e.g., GET, POST
	local endpoint="$3"    # e.g., /auth/login
	local data="$4"        # JSON body (optional)
	local description="$5" #Short descirption
	echo "===============================" | tee -a "$LOG_FILE"
	echo "STEP: $description" | tee -a "$LOG_FILE"
	echo "COMMAND: curl -s -X $method $BASE_URL$endpoint" | tee -a "$LOG_FILE"
	if [ -n "$data" ]; then
		echo "BODY: $data" | tee -a "$LOG_FILE"
		echo -e "\n" | tee -a "$LOG_FILE"
	fi
	echo "OUTPUT:" | tee -a "$LOG_FILE"
	if [ -n "$data" ]; then
		curl -s -X "$method" "$BASE_URL$endpoint" \
			-H "Content-Type: application/json" \
			-d "$data" \
			-b "$COOKIE_JAR" -c "$COOKIE_JAR" | jq | tee -a "$LOG_FILE"
	else
		curl -s -X "$method" "$BASE_URL$endpoint" \
			-b "$COOKIE_JAR" -c "$COOKIE_JAR" | jq | tee -a "$LOG_FILE"
	fi
	echo "STEP: $description - Finished at $(date '+%Y-%m-%d %I:%M:%S %p')" | tee -a "$LOG_FILE"
	echo "=====================================================" | tee -a "$LOG_FILE"
	echo -e "\n" | tee -a "$LOG_FILE"
	sleep 2
}

BASE_URL="https://ecommerce-api-nodejs-2gmv.onrender.com/api/v1"

api_request "$BASE_URL" "POST" "/auth/login" \
	'{
  "email": "sadmanadmin@gmail.com",
  "password": "secret"
}' \
	"Admin Login"

api_request "$BASE_URL" "GET" "/users" "" "Get All Users (admin only)"


api_request "$BASE_URL" "DELETE" "/auth/logout" "" "User Logout"

api_request "$BASE_URL" "POST" "/auth/login" \
	'{
  "email": "sadmanuser@gmail.com",
  "password": "secret"
}' \
	"User Login"

api_request "$BASE_URL" "GET" "/users" "" "Get All Users (admin only)"

api_request "$BASE_URL" "GET" "/products" "" "Get All Products"

api_request "$BASE_URL" "GET" "/products/69436c8d4b2d5e0ffa224980" "" "Get Single Product"

api_request "$BASE_URL" "POST" "/products" \
'{
  "name": "Ergonomic Office Chair",
  "price": 18999,
  "description": "Premium ergonomic office chair with lumbar support, adjustable height and 360-degree swivel",
  "category": "office",
  "company": "ikea",
  "colors": ["#000000", "#808080", "#003366"],
  "featured": true,
  "freeShipping": false,
  "inventory": 25
}' \
"Create New Product"

api_request "$BASE_URL" "POST" "/auth/login" \
	'{
  "email": "sadmanadmin@gmail.com",
  "password": "secret"
}' \
	"Admin Login"

api_request "$BASE_URL" "POST" "/products" \
'{
  "name": "Ergonomic Office Chair",
  "price": 18999,
  "description": "Premium ergonomic office chair with lumbar support, adjustable height and 360-degree swivel",
  "category": "office",
  "company": "ikea",
  "colors": ["#000000", "#808080", "#003366"],
  "featured": true,
  "freeShipping": false,
  "inventory": 25
}' \
"Create New Product"

api_request "$BASE_URL" "GET" "/products/6944bb1b2f5ae32b85764a4e/reviews" "" "Get Product Reviews"

api_request "$BASE_URL" "DELETE" "/auth/logout" "" "User Logout"


api_request "$BASE_URL" "POST" "/auth/login" \
	'{
  "email": "sadmanuser@gmail.com",
  "password": "secret"
}' \
	"User Login"


api_request "$BASE_URL" "GET" "/users/showMe" "" "Show Current User"

api_request "$BASE_URL" "POST" "/reviews" \
'{
  "product": "6944bb1b2f5ae32b85764a4e",
  "rating": 5,
  "title": "Excellent Quality!",
  "comment": "This product exceeded my expectations. Very comfortable and durable."
}' \
"Create Review for Product 6944bb1b2f5ae32b85764a4e"

api_request "$BASE_URL" "PATCH" "/reviews/6944bcab2f5ae32b85764a56" \
'{
  "rating": 4,
  "title": "Updated Review Title",
  "comment": "Updated review comment after using product for a while."
}' \
"Update Review"


api_request "$BASE_URL" "GET" "/reviews" "" "Get All Reviews"

api_request "$BASE_URL" "POST" "/orders" \
'{
  "tax": 250,
  "shippingFee": 500,
  "items": [
    {
      "name": "Ergonomic Office Chair",
      "price": 18999,
      "image": "/uploads/example.jpeg",
      "amount": 1,
      "product": "6944bb1b2f5ae32b85764a4e"
    },
    {
      "name": "Modern Accent Chair",
      "price": 2599,
      "image": "/uploads/example.jpeg",
      "amount": 2,
      "product": "69436c8d4b2d5e0ffa224980"
    },
    {
      "name": "product 1 updated",
      "price": 3000,
      "image": "/uploads/example.jpeg",
      "amount": 3,
      "product": "69336c3e9b2af5d54e5235c9"
    }
  ]
}' \
"Create Order with Multiple Products"

api_request "$BASE_URL" "GET" "/orders/showAllMyOrders" "" "Get My Orders"

api_request "$BASE_URL" "DELETE" "/auth/logout" "" "User Logout"

api_request "$BASE_URL" "POST" "/auth/login" \
    '{
        "email": "sadmanadmin@gmail.com",
        "password": "secret"
    }' \
    "Admin Login"


api_request "$BASE_URL" "GET" "/orders" "" "Get All Orders (Admin)"

api_request "$BASE_URL" "PATCH" "/orders/6942178a980fa7a7cfee4d9a" \
"" \
"Update Order 6942178a980fa7a7cfee4d9a to Paid"

api_request "$BASE_URL" "DELETE" "/auth/logout" "" "Admin Logout"

api_request "$BASE_URL" "POST" "/auth/login" \
    '{
        "email": "sadmanuser@gmail.com",
        "password": "secret"
    }' \
    "Regular User Login"

api_request "$BASE_URL" "DELETE" "/reviews/6944bcab2f5ae32b85764a56" "" "Delete My Review"

api_request "$BASE_URL" "DELETE" "/products/69389f9a2fa68d29032fcf43" "" "Delete Product"

api_request "$BASE_URL" "POST" "/auth/login" \
    '{
        "email": "sadmanadmin@gmail.com",
        "password": "secret"
    }' \
    "Admin Login"

api_request "$BASE_URL" "DELETE" "/products/69389f9a2fa68d29032fcf43" "" "Delete Product"

api_request "$BASE_URL" "DELETE" "/auth/logout" "" "Admin Logout"

