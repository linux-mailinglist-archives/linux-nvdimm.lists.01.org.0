Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD83090E5
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 Jan 2021 01:24:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 64730100EC1D3;
	Fri, 29 Jan 2021 16:24:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ben.widawsky@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BF88100ED4A7
	for <linux-nvdimm@lists.01.org>; Fri, 29 Jan 2021 16:24:46 -0800 (PST)
IronPort-SDR: YoBGgewsaw7bSSBvfqZQWq47yb1SLZgqZoOi1ybVhnfg6jtws7LuRGYJ8vh2KDMju3kUUeLKUk
 bufwAaCaChLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="265333126"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="265333126"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:45 -0800
IronPort-SDR: 2Qr93ZP+aH/uhPOAc0J5zom4DzflXQWWzztfofYSrASo6XXKWnzKVo9aQbDuqJbLce75q5/+gP
 6Qi46MABmQiQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400";
   d="scan'208";a="370591638"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 16:24:44 -0800
From: Ben Widawsky <ben.widawsky@intel.com>
To: linux-cxl@vger.kernel.org
Subject: [PATCH 00/14] CXL 2.0 Support
Date: Fri, 29 Jan 2021 16:24:24 -0800
Message-Id: <20210130002438.1872527-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Message-ID-Hash: TW4NTVSIG3OT3JG4O4XLH4F45UU6SDRT
X-Message-ID-Hash: TW4NTVSIG3OT3JG4O4XLH4F45UU6SDRT
X-MailFrom: ben.widawsky@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TW4NTVSIG3OT3JG4O4XLH4F45UU6SDRT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

IyBDaGFuZ2VzIHNpbmNlIFJGQyB2MyBbMV0NCiAgICogQWRkZWQgZXJyb3IgbWVzc2FnZSB3aGVu
IHBheWxvYWQgc2l6ZSBpcyB0b28gc21hbGwuIChCZW4pDQogICAqIEZpeCBpbmNsdWRlcyBpbiBV
QVBJIGZvciBDbGFuZyAoTEtQKQ0KICAgKiBSZW9yZGVyIENYTCBpbiBNQUlOVEFJTkVSUyAoSm9l
IFBlcmNoZXMpDQogICAqIEtjb25maWcgd2hpdGVzcGFjZSBhbmQgc3BlbGxpbmcgZml4ZXMgKFJh
bmR5KQ0KICAgKiBSZW1vdmUgZXhjZXNzIGZyZWVzIGNvbnRyb2xsZWQgYnkgZGV2bSwgaW50cm9k
dWNlZCBpbiB2MyAoSm9uYXRoYW4sIERhbikNCiAgICogVXNlICdQQ0kgRXhwcmVzcycgaW5zdGVh
ZCBvZiAnUENJLUUnIGluIEtjb25maWcgKEpvbmF0aGFuKQ0KICAgKiBGYWlsIHdoZW4gbWFpbGJv
eCBjb21tYW5kcyByZXR1cm4gdmFsdWUgaXMgYW4gZXJyb3IgKEpvbmF0aGFuKQ0KICAgKiBBZGQg
Y29tbWVudCB0byBtYWlsYm94IHByb3RvY29sIHRvIGV4cGxhaW4gb3JkZXJpbmcgb2Ygb3BlcmF0
aW9ucw0KICAgICAoSm9uYXRoYW4sIEJlbikNCiAgICogRmFpbCBtYWlsYm94IHhmZXIgd2hlbiBk
b29yYmVsbCBpcyBidXN5LiAoSm9uYXRoYW4pDQogICAqIFJlbW92ZSBleHRyYW5lb3VzIFNISUZU
IGRlZmluZXMuIChKb25hdGhhbikNCiAgICogQ2hhbmdlIGtkb2NzIGZvciBtYm94X2NtZCBzaXpl
X291dCB0byBvdXRwdXQgb25seS4gKEpvbmF0aGFuKQ0KICAgKiBGaXggdHJhbnNpZW50IGJ1ZyAo
RU5PVFRZKSBpbiBDWExfTUVNX1FVRVJZX0NPTU1BTkRTIChKb25hdGhhbikNCiAgICogQWRkIHNv
bWUgY29tbWVudHMgYW5kIGNvZGUgYmVhdXRpZmljYXRpb24gdG8gbWJveCBjb21tYW5kcyAoSm9u
YXRoYW4pDQogICAqIEFkZCBzb21lIGNvbW1lbnRzIGFuZCBjb2RlIGJlYXV0aWZpY2F0aW9uIHRv
IHVzZXIgY29tbWFuZHMgKEpvbmF0aGFuKQ0KICAgKiBGaXggYm9ndXMgY2hlY2sgb2YgbWVtY3B5
IHJldHVybiB2YWx1ZSAoQmVuKQ0KICAgKiBBZGQgY29uY2VwdCBvZiBibG9ja2luZyBjZXJ0YWlu
IFJBVyBvcGNvZGVzIChEYW4pDQogICAqIEFkZCBkZWJ1Z2ZzIGtub2IgdG8gYWxsb3cgYWxsIFJB
VyBvcGNvZGVzIChWaXNoYWwpDQogICAqIE1vdmUgZG9jcyB0byBkcml2ZXItYXBpLyAoRGFuKQ0K
ICAgKiBVc2UgYm91bmNlIGJ1ZmZlciBhZ2FpbiBsaWtlIGluIHYyIChKb25hdGhhbikNCiAgICAg
ICAqIFVzZSBrdnphbGxvYyBpbnN0ZWFkIG9mIG1lbWR1cCAoQmVuKQ0KICAgKiBXb3Jkc21pdGgg
c29tZSBjaGFuZ2Vsb2dzIGFuZCBkb2N1bWVudGF0aW9uIChEYW4pDQogICAqIFVzZSBhIHBlcmNw
dV9yZWYgY291bnRlciB0byBwcm90ZWN0IGRldm0gYWxsb2NhdGVkIGRhdGEgaW4gdGhlIGlvY3Rs
IHBhdGgNCiAgICAgKERhbikNCiAgICogUmV3b3JrIGNkZXYgcmVnaXN0cmF0aW9uIGFuZCBsb29r
dXAgdG8gdXNlIGlub2RlLT5pX2NkZXYgKERhbikNCiAgICogRHJvcCBtdXRleF9sb2NrX2ludGVy
cnVwdGlibGUoKSBmcm9tIGlvY3RsIHBhdGggKERhbikNCiAgICogQ29udmVydCBhZGRfdGFpbnQo
KSB0byBXQVJOX1RBSU5UX09OQ0UoKQ0KICAgKiBEcm9wIEFDUEkgY29vcmRpbmF0aW9uIGZvciBw
dXJlIG1haWxib3ggZHJpdmVyIG1pbGVzdG9uZSAoRGFuKQ0KICAgKiBQZXJtaXQgR0VUX0xPRyB3
aXRoIENFTF9VVUlEIChCZW4pDQogICAqIENvdmVyIGxldHRlciBvdmVyaGF1bCAoQmVuKQ0KICAg
KiBVc2UgaW5mby5pZCBpbnN0ZWFkIG9mIENYTF9DT01NQU5EX0lOREVYIChEYW4pDQogICAqIEFk
ZCBzZXZlcmFsIG5ldyBjb21tYW5kcyB0byB0aGUgbWFpbGJveCBpbnRlcmZhY2UgKEJlbikNCg0K
LS0tDQoNCkluIGFkZGl0aW9uIHRvIHRoZSBtYWlsaW5nIGxpc3QsIHBsZWFzZSBmZWVsIGZyZWUg
dG8gdXNlICNjeGwgb24gb2Z0YyBJUkMgZm9yDQpkaXNjdXNzaW9uLg0KDQotLS0NCg0KIyBTdW1t
YXJ5DQoNCkludHJvZHVjZSBzdXBwb3J0IGZvciDigJx0eXBlLTPigJ0gbWVtb3J5IGRldmljZXMg
ZGVmaW5lZCBpbiB0aGUgQ29tcHV0ZSBFeHByZXNzDQpMaW5rIChDWEwpIDIuMCBzcGVjaWZpY2F0
aW9uIFsyXS4gU3BlY2lmaWNhbGx5LCB0aGVzZSBhcmUgdGhlIG1lbW9yeSBkZXZpY2VzDQpkZWZp
bmVkIGJ5IHNlY3Rpb24gOC4yLjguNSBvZiB0aGUgQ1hMIDIuMCBzcGVjLiBBIHJlZmVyZW5jZSBp
bXBsZW1lbnRhdGlvbg0KZW11bGF0aW5nIHRoZXNlIGRldmljZXMgaGFzIGJlZW4gc3VibWl0dGVk
IHRvIHRoZSBRRU1VIG1haWxpbmcgbGlzdCBbM10gYW5kIGlzDQphdmFpbGFibGUgb24gZ2l0bGFi
IFs0XSwgYnV0IHdpbGwgbW92ZSB0byBhIHNoYXJlZCB0cmVlIG9uIGtlcm5lbC5vcmcgYWZ0ZXIN
CmluaXRpYWwgYWNjZXB0YW5jZS4g4oCcVHlwZS0z4oCdIGlzIGEgQ1hMIGRldmljZSB0aGF0IGFj
dHMgYXMgYSBtZW1vcnkgZXhwYW5kZXIgZm9yDQpSQU0gb3IgUGVyc2lzdGVudCBNZW1vcnkuIFRo
ZSBkZXZpY2UgbWlnaHQgYmUgaW50ZXJsZWF2ZWQgd2l0aCBvdGhlciBDWEwgZGV2aWNlcw0KaW4g
YSBnaXZlbiBwaHlzaWNhbCBhZGRyZXNzIHJhbmdlLg0KDQpJbiBhZGRpdGlvbiB0byB0aGUgY29y
ZSBmdW5jdGlvbmFsaXR5IG9mIGRpc2NvdmVyaW5nIHRoZSBzcGVjIGRlZmluZWQgcmVnaXN0ZXJz
DQphbmQgcmVzb3VyY2VzLCBpbnRyb2R1Y2UgYSBDWEwgZGV2aWNlIG1vZGVsIHRoYXQgd2lsbCBi
ZSB0aGUgZm91bmRhdGlvbiBmb3INCnRyYW5zbGF0aW5nIENYTCBjYXBhYmlsaXRpZXMgaW50byBl
eGlzdGluZyBMaW51eCBpbmZyYXN0cnVjdHVyZSBmb3IgUGVyc2lzdGVudA0KTWVtb3J5IGFuZCBv
dGhlciBtZW1vcnkgZGV2aWNlcy4gRm9yIG5vdywgdGhpcyBvbmx5IGluY2x1ZGVzIHN1cHBvcnQg
Zm9yIHRoZQ0KbWFuYWdlbWVudCBjb21tYW5kIG1haWxib3ggdGhlIHN1cmZhY2luZyBvZiB0eXBl
LTMgZGV2aWNlcy4gVGhlc2UgY29udHJvbA0KZGV2aWNlcyBmaWxsIHRoZSByb2xlIG9mIOKAnERJ
TU1z4oCdIC8gbm1lbVggbWVtb3J5LWRldmljZXMgaW4gTElCTlZESU1NIHRlcm1zLg0KDQojIyBV
c2Vyc3BhY2UgSW50ZXJhY3Rpb24NCg0KSW50ZXJhY3Rpb24gd2l0aCB0aGUgZHJpdmVyIGFuZCB0
eXBlLTMgZGV2aWNlcyB2aWEgdGhlIENYTCBkcml2ZXJzIGlzIGludHJvZHVjZWQNCmluIHRoaXMg
cGF0Y2ggc2VyaWVzIGFuZCBjb25zaWRlcmVkIHN0YWJsZSBBQkkuIFRoZXkgaW5jbHVkZQ0KDQog
ICAqIHN5c2ZzIC0gRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9zeXNmcy1idXMtY3hsDQogICAq
IElPQ1RMIC0gRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2N4bC9tZW1vcnktZGV2aWNlcy5yc3QN
CiAgICogZGVidWdmcyAtIERvY3VtZW50YXRpb24vQUJJL3Rlc3RpbmcvZGVidWdmcy1kZWJ1Zw0K
DQoNCldvcmsgaXMgaW4gcHJvY2VzcyB0byBhZGQgc3VwcG9ydCBmb3IgQ1hMIGludGVyYWN0aW9u
cyB0byB0aGUgbmRjdGwgcHJvamVjdCBbNV0NCg0KIyMjIERldmVsb3BtZW50IHBsYW5zDQoNCk9u
ZSBvZiB0aGUgdW5pcXVlIGNoYWxsZW5nZXMgdGhhdCBDWEwgaW1wb3NlcyBvbiB0aGUgTGludXgg
ZHJpdmVyIG1vZGVsIGlzIHRoYXQNCml0IHJlcXVpcmVzIHRoZSBvcGVyYXRpbmcgc3lzdGVtIHRv
IHBlcmZvcm0gcGh5c2ljYWwgYWRkcmVzcyBzcGFjZSBtYW5hZ2VtZW50DQppbnRlcmxlYXZlZCBh
Y3Jvc3MgZGV2aWNlcyBhbmQgYnJpZGdlcy4gV2hlcmVhcyBMSUJOVkRJTU0gaGFuZGxlcyBhIGxp
c3Qgb2YNCmVzdGFibGlzaGVkIHN0YXRpYyBwZXJzaXN0ZW50IG1lbW9yeSBhZGRyZXNzIHJhbmdl
cyAoZm9yIGV4YW1wbGUgZnJvbSB0aGUgQUNQSQ0KTkZJVCksIENYTCBpbnRyb2R1Y2VzIGhvdHBs
dWcgYW5kIHRoZSBjb25jZXB0IG9mIGFsbG9jYXRpbmcgYWRkcmVzcyBzcGFjZSB0bw0KaW5zdGFu
dGlhdGUgcGVyc2lzdGVudCBtZW1vcnkgcmFuZ2VzLiBUaGlzIGlzIHNpbWlsYXIgdG8gUENJIGlu
IHRoZSBzZW5zZSB0aGF0DQp0aGUgcGxhdGZvcm0gZXN0YWJsaXNoZXMgdGhlIE1NSU8gcmFuZ2Ug
Zm9yIFBDSSBCQVJzIHRvIGJlIGFsbG9jYXRlZCwgYnV0IGl0IGlzDQpzaWduaWZpY2FudGx5IGNv
bXBsaWNhdGVkIGJ5IHRoZSBmYWN0IHRoYXQgYSBnaXZlbiBkZXZpY2UgY2FuIG9wdGlvbmFsbHkg
YmUNCmludGVybGVhdmVkIHdpdGggb3RoZXIgZGV2aWNlcyBhbmQgY2FuIHBhcnRpY2lwYXRlIGlu
IHNldmVyYWwgaW50ZXJsZWF2ZS1zZXRzIGF0DQpvbmNlLiBMSUJOVkRJTU0gaGFuZGxlZCBzb21l
dGhpbmcgbGlrZSB0aGlzIHdpdGggdGhlIGFsaWFzaW5nIGJldHdlZW4gUE1FTSBhbmQNCkJMT0NL
LVdJTkRPVyBtb2RlLCBidXQgQ1hMIGFkZHMgZmxleGliaWxpdHkgdG8gYWxpYXMgREVWSUNFIE1F
TU9SWSB0aHJvdWdoIHVwIHRvDQoxMCBkZWNvZGVycyBwZXIgZGV2aWNlLg0KDQpBbGwgb2YgdGhl
IGFib3ZlIG5lZWRzIHRvIGJlIGVuYWJsZWQgd2l0aCByZXNwZWN0IHRvIFBDSSBob3RwbHVnIGV2
ZW50cyBvbg0KVHlwZS0zIG1lbW9yeSBkZXZpY2Ugd2hpY2ggbmVlZHMgaG9va3MgdG8gZGV0ZXJt
aW5lIGlmIGEgZ2l2ZW4gZGV2aWNlIGlzDQpjb250cmlidXRpbmcgdG8gYSAiU3lzdGVtIFJBTSIg
YWRkcmVzcyByYW5nZSB0aGF0IGlzIHVuYWJsZSB0byBiZSB1bnBsdWdnZWQuIEluDQpvdGhlciB3
b3JkcyBDWEwgdGllcyBQQ0kgaG90cGx1ZyB0byBNZW1vcnkgSG90cGx1ZyBhbmQgUENJIGhvdHBs
dWcgbmVlZHMgdG8gYmUNCmFibGUgdG8gbmVnb3RpYXRlIHdpdGggbWVtb3J5IGhvdHBsdWcuICBJ
biB0aGUgbWVkaXVtIHRlcm0gdGhlIGltcGxpY2F0aW9ucyBvZg0KQ1hMIGhvdHBsdWcgdnMgQUNQ
SSBTUkFUL1NMSVQvSE1BVCBuZWVkIHRvIGJlIHJlY29uY2lsZWQuIE9uZSBjYXBhYmlsaXR5IHRo
YXQNCnNlZW1zIHRvIGJlIG5lZWRlZCBpcyBlaXRoZXIgdGhlIGR5bmFtaWMgYWxsb2NhdGlvbiBv
ZiBuZXcgbWVtb3J5IG5vZGVzLCBvcg0KZGVmYXVsdCBpbml0aWFsaXppbmcgZXh0cmEgcGdkYXQg
aW5zdGFuY2VzIGJleW9uZCB3aGF0IGlzIGVudW1lcmF0ZWQgaW4gQUNQSQ0KU1JBVCB0byBhY2Nv
bW1vZGF0ZSBob3QtYWRkZWQgQ1hMIG1lbW9yeS4NCg0KUGF0Y2hlcyB3ZWxjb21lLCBxdWVzdGlv
bnMgd2VsY29tZSBhcyB0aGUgZGV2ZWxvcG1lbnQgZWZmb3J0IG9uIHRoZSBwb3N0IHY1LjEyDQpj
YXBhYmlsaXRpZXMgcHJvY2VlZHMuDQoNCiMjIFJ1bm5pbmcgaW4gUUVNVQ0KDQpUaGUgaW5jYW50
YXRpb24gdG8gZ2V0IENYTCBzdXBwb3J0IGluIFFFTVUgWzRdIGlzIGNvbnNpZGVyZWQgdW5zdGFi
bGUgYXQgdGhpcw0KdGltZS4gRnV0dXJlIHJlYWRlcnMgb2YgdGhpcyBjb3ZlciBsZXR0ZXIgc2hv
dWxkIHZlcmlmeSBpZiBhbnkgY2hhbmdlcyBhcmUNCm5lZWRlZC4gRm9yIHRoZSBub3ZpY2UgUUVN
VSB1c2VyLCB0aGUgZm9sbG93aW5nIGNhbiBiZSBjb3B5L3Bhc3RlZCBpbnRvIGENCndvcmtpbmcg
UUVNVSBjb21tYW5kbGluZS4gSXQgaXMgZW5vdWdoIHRvIG1ha2UgdGhlIHNpbXBsZXN0IHRvcG9s
b2d5IHBvc3NpYmxlLg0KVGhlIHRvcG9sb2d5IHdvdWxkIGNvbnNpc3Qgb2YgYSBzaW5nbGUgbWVt
b3J5IHdpbmRvdywgc2luZ2xlIHR5cGUzIGRldmljZSwNCnNpbmdsZSByb290IHBvcnQsIGFuZCBz
aW5nbGUgaG9zdCBicmlkZ2UuDQoNCiAgICArLS0tLS0tLS0tLS0tLSsNCiAgICB8ICAgQ1hMIFBY
QiAgIHwNCiAgICB8ICAgICAgICAgICAgIHwNCiAgICB8ICArLS0tLS0tLSsgIHw8LS0tLS0tLS0t
LSsNCiAgICB8ICB8Q1hMIFJQIHwgIHwgICAgICAgICAgIHwNCiAgICArLS0rLS0tLS0tLSstLSsg
ICAgICAgICAgIHYNCiAgICAgICAgICAgfCAgICAgICAgICAgICstLS0tLS0tLS0tKw0KICAgICAg
ICAgICB8ICAgICAgICAgICAgfCAid2luZG93IiB8DQogICAgICAgICAgIHwgICAgICAgICAgICAr
LS0tLS0tLS0tLSsNCiAgICAgICAgICAgdiAgICAgICAgICAgICAgICAgIF4NCiAgICArLS0tLS0t
LS0tLS0tLSsgICAgICAgICAgIHwNCiAgICB8ICBDWEwgVHlwZSAzIHwgICAgICAgICAgIHwNCiAg
ICB8ICAgRGV2aWNlICAgIHw8LS0tLS0tLS0tLSsNCiAgICArLS0tLS0tLS0tLS0tLSsNCg0KLy8g
TWVtb3J5IGJhY2tlbmQNCi1vYmplY3QgbWVtb3J5LWJhY2tlbmQtZmlsZSxpZD1jeGwtbWVtMSxz
aGFyZSxtZW0tcGF0aD1jeGwtdHlwZTMsc2l6ZT01MTJNDQoNCi8vIEhvc3QgQnJpZGdlDQotZGV2
aWNlIHB4Yi1jeGwgaWQ9Y3hsLjAsYnVzPXBjaWUuMCxidXNfbnI9NTIsdWlkPTAgbGVuLXdpbmRv
dy1iYXNlPTEsd2luZG93LWJhc2VbMF09MHg0YzAwMDAwMDAgbWVtZGV2WzBdPWN4bC1tZW0xDQoN
Ci8vIFNpbmdsZSByb290IHBvcnQNCi1kZXZpY2UgY3hsIHJwLGlkPXJwMCxidXM9Y3hsLjAsYWRk
cj0wLjAsY2hhc3Npcz0wLHNsb3Q9MCxtZW1kZXY9Y3hsLW1lbTENCg0KLy8gU2luZ2xlIHR5cGUz
IGRldmljZQ0KLWRldmljZSBjeGwtdHlwZTMsYnVzPXJwMCxtZW1kZXY9Y3hsLW1lbTEsaWQ9Y3hs
LXBtZW0wLHNpemU9MjU2TSAtZGV2aWNlIGN4bC10eXBlMyxidXM9cnAxLG1lbWRldj1jeGwtbWVt
MSxpZD1jeGwtcG1lbTEsc2l6ZT0yNTZNDQoNCi0tLQ0KDQpbMV06IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWN4bC8yMDIwMTIwOTAwMjQxOC4xOTc2MzYyLTEtYmVuLndpZGF3c2t5QGlu
dGVsLmNvbS8NClsyXTogaHR0cHM6Ly93d3cuY29tcHV0ZWV4cHJlc3NsaW5rLm9yZy9dKGh0dHBz
Oi8vd3d3LmNvbXB1dGVleHByZXNzbGluay5vcmcvDQpbM106IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyMTAxMDUxNjUzMjMuNzgzNzI1LTEtYmVuLndpZGF3c2t5QGludGVs
LmNvbS9ULyN0DQpbNF06IGh0dHBzOi8vZ2l0bGFiLmNvbS9id2lkYXdzay9xZW11Ly0vdHJlZS9j
eGwtMi4wdioNCls1XTogaHR0cHM6Ly9naXRodWIuY29tL3BtZW0vbmRjdGwvdHJlZS9jeGwtMi4w
dioNCg0KDQpCZW4gV2lkYXdza3kgKDEyKToNCiAgY3hsL21lbTogTWFwIG1lbW9yeSBkZXZpY2Ug
cmVnaXN0ZXJzDQogIGN4bC9tZW06IEZpbmQgZGV2aWNlIGNhcGFiaWxpdGllcw0KICBjeGwvbWVt
OiBJbXBsZW1lbnQgcG9sbGVkIG1vZGUgbWFpbGJveA0KICBjeGwvbWVtOiBBZGQgYmFzaWMgSU9D
VEwgaW50ZXJmYWNlDQogIGN4bC9tZW06IEFkZCBzZW5kIGNvbW1hbmQNCiAgdGFpbnQ6IGFkZCB0
YWludCBmb3IgZGlyZWN0IGhhcmR3YXJlIGFjY2Vzcw0KICBjeGwvbWVtOiBBZGQgYSAiUkFXIiBz
ZW5kIGNvbW1hbmQNCiAgY3hsL21lbTogQ3JlYXRlIGNvbmNlcHQgb2YgZW5hYmxlZCBjb21tYW5k
cw0KICBjeGwvbWVtOiBVc2UgQ0VMIGZvciBlbmFibGluZyBjb21tYW5kcw0KICBjeGwvbWVtOiBB
ZGQgc2V0IG9mIGluZm9ybWF0aW9uYWwgY29tbWFuZHMNCiAgY3hsL21lbTogQWRkIGxpbWl0ZWQg
R2V0IExvZyBjb21tYW5kICgwNDAxaCkNCiAgTUFJTlRBSU5FUlM6IEFkZCBtYWludGFpbmVycyBv
ZiB0aGUgQ1hMIGRyaXZlcg0KDQpEYW4gV2lsbGlhbXMgKDIpOg0KICBjeGwvbWVtOiBJbnRyb2R1
Y2UgYSBkcml2ZXIgZm9yIENYTC0yLjAtVHlwZS0zIGVuZHBvaW50cw0KICBjeGwvbWVtOiBSZWdp
c3RlciBDWEwgbWVtWCBkZXZpY2VzDQoNCiAuY2xhbmctZm9ybWF0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxICsNCiBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL2RlYnVn
ZnMtY3hsICAgICAgICAgfCAgIDEwICsNCiBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LWJ1cy1jeGwgICAgICAgfCAgIDI2ICsNCiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3N5c2N0
bC9rZXJuZWwucnN0ICAgfCAgICAxICsNCiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3RhaW50
ZWQta2VybmVscy5yc3QgfCAgICA2ICstDQogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2N4bC9p
bmRleC5yc3QgICAgICAgIHwgICAxMiArDQogLi4uL2RyaXZlci1hcGkvY3hsL21lbW9yeS1kZXZp
Y2VzLnJzdCAgICAgICAgIHwgICA0NiArDQogRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2luZGV4
LnJzdCAgICAgICAgICAgIHwgICAgMSArDQogLi4uL3VzZXJzcGFjZS1hcGkvaW9jdGwvaW9jdGwt
bnVtYmVyLnJzdCAgICAgIHwgICAgMSArDQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAxMSArDQogZHJpdmVycy9LY29uZmlnICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQogZHJpdmVycy9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQogZHJpdmVycy9iYXNlL2NvcmUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAxNCArDQogZHJpdmVycy9jeGwvS2NvbmZpZyAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICA0OSArDQogZHJpdmVycy9jeGwvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgNyArDQogZHJpdmVycy9jeGwvYnVzLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAyOSArDQogZHJpdmVycy9jeGwvY3hsLmggICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDE0MCArKw0KIGRyaXZlcnMvY3hsL21lbS5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8IDE2MDMgKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2N4bC9w
Y2kuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDM0ICsNCiBpbmNsdWRlL2xpbnV4
L2RldmljZS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiBpbmNsdWRlL2xpbnV4
L2tlcm5lbC5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAzICstDQogaW5jbHVkZS91YXBp
L2xpbnV4L2N4bF9tZW0uaCAgICAgICAgICAgICAgICAgIHwgIDE4MCArKw0KIGtlcm5lbC9wYW5p
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIDIzIGZpbGVzIGNo
YW5nZWQsIDIxNzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9BQkkvdGVzdGluZy9kZWJ1Z2ZzLWN4bA0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2ZzLWJ1cy1jeGwNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2N4bC9pbmRleC5yc3QNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL2N4bC9tZW1vcnktZGV2aWNl
cy5yc3QNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jeGwvS2NvbmZpZw0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2N4bC9NYWtlZmlsZQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2N4bC9idXMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2N4bC9jeGwuaA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2N4bC9tZW0uYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2N4bC9wY2kuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3VhcGkvbGludXgv
Y3hsX21lbS5oDQoNCi0tIA0KMi4zMC4wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
