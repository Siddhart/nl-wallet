class RequestedAttributeBlock {
  final String n;
  final List<String> a;
  final String i;

  RequestedAttributeBlock({
    required this.n,
    required this.a,
    required this.i,
  });

  factory RequestedAttributeBlock.fromJson(Map<String, dynamic> json) {
    return RequestedAttributeBlock(
      n: json['n'] as String,
      a: List<String>.from(json['a'] as List),
      i: json['i'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'n': n,
      'a': a,
      'i': i,
    };
  }
}

class QrCodeData {
  final String pn;
  final String ep;
  final String r;
  final List<RequestedAttributeBlock> ra;
  final String pi;

  QrCodeData({
    required this.pn,
    required this.ep,
    required this.r,
    required this.ra,
    required this.pi,
  });

  factory QrCodeData.fromJson(Map<String, dynamic> json) {
    return QrCodeData(
      pn: json['pn'] as String,
      ep: json['ep'] as String,
      r: json['r'] as String,
      ra: (json['ra'] as List)
          .map((e) => RequestedAttributeBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
      pi: json['pi'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pn': pn,
      'ep': ep,
      'r': r,
      'ra': ra.map((e) => e.toJson()).toList(),
      'pi': pi,
    };
  }
} 