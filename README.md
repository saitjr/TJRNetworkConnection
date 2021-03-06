TJRNetworkConnection
====================

自己封装的网络请求以及网络请求框架

## 网路请求框架介绍

该网络请求框架分为三层：

第一层：控件触发处理（配置网络请求参数）

第二层：封装一个基础的网络请求单例，并在单例中写四个共有方法（即：GET同步请求、GET异步请求、POST同步请求、POST异步请求）。在这一层中，为每一个请求都创建一个类目，类目主要用户将参数封装为字典，并配置请求链接，防止请求参数混乱以及合作开发时的冲突。

第三层：自己封装的网络请求层。公开四种请求方法，并使用block进行回调。

## 这种框架的优势

1. 方便管理每一个请求方法；
2. 方便合作开发，避免代码冲突；
3. 可以灵活变动第三层内容。（如果需要将自己封装的网络请求改为三方，那么只需要将第三层换为三方网络请求，在第二层的基础类中，修改参数配置即可，程序其他地方，均可不变）。

