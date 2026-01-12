import 'dart:io';

class VDevice {
  //获取所有的地址
  static Future<String> getLocalIpAddress() async {
    try {
      //获取设备上的网络信息接口
      List<NetworkInterface> interfaces = await NetworkInterface.list();
      bool isPrivate = false;
      String address = '';
      for (var i = 0; i < interfaces.length; i++) {
        NetworkInterface interface2 = interfaces[i];
        for (var j = 0; j < interface2.addresses.length; j++) {
          InternetAddress internetAddress = interface2.addresses[j];
          String ipAddress = interface2.addresses[j].address;
          //判断Address是否是私有地址
          if (internetAddress.type == InternetAddressType.IPv4) {
            isPrivate = true;
            address = ipAddress;
            break;
          }
        }
        if (isPrivate) {
          break;
        }
      }
      return address;
    } catch (e) {
      return '0.0.0.0';
    }
  }
}
