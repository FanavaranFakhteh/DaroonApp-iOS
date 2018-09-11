# DaroonApp-iOS



# CocoaPods
add to podfile:
```
pod 'DaroonApp'
```

# Carthage
add to cartfile:
```
github "FanavaranFakhteh/DaroonApp-iOS"
```

# Manual
download last released framework here:
https://github.com/FanavaranFakhteh/DaroonApp-iOS/releases




# How to use
DaroonApp code snippests is available in xcode (Quick Help)

but here is a quick setup:


1. import framework:
```
import DaroonApp
```

2. register your token (app delegate is usually a good place):
```
DaroonApp.shared.setup(token: "TOKEN_HERE")
```

3. add DaroonApp delegate to your view controller:
```
DaroonApp.shared.delegate = self
```

4. make a payment object:
```
let payment = DAPayment(email: "EMAIL", amount: 5000, mobile: "PHONE_NUMBER", extraData: nil)
```

5. start a payment:
```
DaroonApp.shared.pay(target: self, payment: payment) { (error) in
        // handle error here
        }
```

check the last transaction , if exist:
```
DaroonApp.shared.getLastTransaction { (error, object) in
  // do any logic here
}
```

check all transactions of user , if exist:
```
DaroonApp.shared.getAllTransactions(mobile: "PHONE_NUMBER") { (error, transactions) in
  // do any logic here
        }
```
