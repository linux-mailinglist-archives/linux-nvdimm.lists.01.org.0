Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480031226D
	for <lists+linux-nvdimm@lfdr.de>; Sun,  7 Feb 2021 09:17:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7A247100EBBCD;
	Sun,  7 Feb 2021 00:17:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.191.226; helo=app5.appendleadedm.info; envelope-from=contact-linux+2dnvdimm=lists.01.org@appendleadedm.info; receiver=<UNKNOWN> 
Received: from app5.appendleadedm.info (ip226.ip-51-83-191.eu [51.83.191.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BD34100EC1C6
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 00:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=appendleadedm.info;
 h=Date:To:From:Reply-To:Subject:Message-ID:List-Unsubscribe:List-Id:MIME-Version:Content-Type; i=contact@appendleadedm.info;
 bh=wlIMH4bVm0ryU87nabcpe0VRYlU=;
 b=CH04ICY9wzew9/olJq8WZv7+rvGecHh9nC7enkoGyvVMhK4g3fIFq6dgsJU0tQC/ZQRIDU5AfFo9
   z1THxmstjOt9CiwmnJwXkcEFkmcj+AwdIdE2iP8/YsJKs26CtfBBXBONiAX6aM8q45+Hdw7XqcYR
   NTgk1dnrs0jtjxgffXokDuQNZ84pWqupSQR70wRVC3OvOgGfSAcDkj+5OL0ERNWQWKsua/nIKj1p
   h6AD43dZ7UmRckUIAJDFXI7bySRY2x+MryoEys9Oktlw0Xv4fsa6dCCTgQ45jUJhcssVCv8EoEnm
   DlEKfDbrScwytVA+rM6XuiNk9gY4Hj+iEAmWiA==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=default; d=appendleadedm.info;
 b=eHFV7G7o9eoM3Mx3IgcoGycbwkH10/9z4wXOfo95rfg862in8B9cT4D6iPROKpuN4Xi07+XnyVFA
   Q18K9tBA04/oFDLoSK8xaL3U54rZszVzzUAKJcti5TDQu3NfVftxvNNEtZVjWmociGRsziU66KPd
   Z3f9R6kupTpUisrSO5vYjS/T6xnlEOJotiJMQdP23DjO6VA3/Bs8iDnd/uprHDpr4EI4CGFQUxEV
   J7GVdc8muJpjoPOdnDNjMc9k5Vpnwb5KbfaA4JxtVO5S++EmMezQ5vZEkTuRIT4UO8i6bjwj/+KC
   cEv9fOT/5wtSpRgeB7u+uAVSo7sTw82lgY74YA==;
Received: from appendleadedm.info (127.0.0.1) by app1.appendleadedm.info id h3uh0di19tk3 for <linux-nvdimm@lists.01.org>; Sun, 7 Feb 2021 08:17:07 +0000 (envelope-from <contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info>)
Date: Sun, 7 Feb 2021 08:17:07 +0000
To: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
From: Sophia Williams <contact@appendleadedm.info>
Subject: RE: Follow up
Message-ID: <69ca52e83d89bd0130268722740d15a8@appendleadedm.info>
X-Ooqx-Campaign-Uid: se901pnlwp336
X-Ooqx-Subscriber-Uid: qm572ras4eff5
X-Ooqx-Customer-Uid: fv107j3jh8cf0
X-Ooqx-Customer-Gid: 0
X-Ooqx-Delivery-Sid: 1
X-Ooqx-Tracking-Did: 0
X-Report-Abuse: Please report abuse for this campaign here: http://appendleadedm.info/emm/index.php/campaigns/se901pnlwp336/report-abuse/sr6194wpxree4/qm572ras4eff5
Feedback-ID: se901pnlwp336:qm572ras4eff5:sr6194wpxree4:fv107j3jh8cf0
Precedence: bulk
X-Ooqx-EBS: http://appendleadedm.info/emm/index.php/lists/block-address
X-Sender: contact@appendleadedm.info
X-Receiver: linux-nvdimm@lists.01.org
X-Ooqx-Mailer: PHPMailer - 5.2.21
MIME-Version: 1.0
Message-ID-Hash: QEVJYEB2FND7I34EVH6SQQ7SHCLJITUC
X-Message-ID-Hash: QEVJYEB2FND7I34EVH6SQQ7SHCLJITUC
X-MailFrom: contact-linux+2Dnvdimm=lists.01.org@appendleadedm.info
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Reply-To: Sophia Williams <sophia.williams@edmstarmarketing.info>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QEVJYEB2FND7I34EVH6SQQ7SHCLJITUC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Q2FuIEkgc2hhcmUgeW91ciBjbGllbnRzIGRhdGEgc2FtcGxlIHdpdGggeW91Pw0KKiBBcmNoaXRl
Y3RzIGFuZCBpbnRlcmlvciBkZXNpZ25lcnMgZW1haWwgbGlzdA0KKiBDRU8sIG93bmVyLCBQcmVz
aWRlbnQgYW5kIENPTyBjb250YWN0cw0KKiBDRk8sIENvbnRyb2xsZXIsIFZQL0RpcmVjdG9yL01h
bmFnZXIgb2YgRmluYW5jZSwgQWNjb3VudHMgUGF5YWJsZSwNCkFjY291bnRzIFJlY2VpdmFibGUs
IEF1ZGl0IENvbnRhY3RzDQoqIENoaWVmIEh1bWFuIFJlc291cmNlcyBPZmZpY2VyLCBWUC9EaXJl
Y3Rvci9NYW5hZ2VyIG9mIEhSLCBFbXBsb3llZQ0KQmVuZWZpdHMsIEVtcGxveWVlIENvbW11bmlj
YXRpb25zLCBFbXBsb3llZSBDb21wZW5zYXRpb24sIEVtcGxveWVlDQpFbmdhZ2VtZW50LCBFbXBs
b3llZSBFeHBlcmllbmNlIGFuZCBFbXBsb3llZSBSZWxhdGlvbnMsIFRhbGVudA0KQWNxdWlzaXRp
b24sIFRhbGVudCBEZXZlbG9wbWVudCwgVGFsZW50IE1hbmFnZW1lbnQsIFJlY3J1aXRpbmcNCkNv
bnRhY3RzDQoqIENJTyxDVE8sIENJU08sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgSVQsIElUIENv
bXBsaWFuY2UsIElUIFJpc2ssDQpCSSwgQ2xvdWQsIERhdGFiYXNlIGFuZCBJVCBTZWN1cml0eSBD
b250YWN0cw0KKiBDTU8sIFZQL0RpcmVjdG9yL01hbmFnZXIgb2YgTWFya2V0aW5nLCBzb2NpYWwg
bWVkaWEsIFNhbGVzLCBkZW1hbmQNCmdlbmVyYXRpb24sIExlYWQgZ2VuZXJhdGlvbiwgaW5zaWRl
IHNhbGVzLCBNYXJrZXRpbmcgQ29tbXVuaWNhdGlvbnMNCmNvbnRhY3RzIGV0Yy4NCiogQ29tcGxp
YW5jZSBhbmQgUmlzayBNYW5hZ2VtZW50IENvbnRhY3RzDQoqIENQQSBhbmQgQm9va2tlZXBlcnMg
ZW1haWwgbGlzdA0KKiBEYXRhIEFuYWx5dGljcyBhbmQgRGF0YWJhc2UgQWRtaW5pc3RyYXRvcnMg
Y29udGFjdHMNCiogRGlzYXN0ZXIgUmVjb3ZlcnkgQ29udGFjdHMNCiogRS1jb21tZXJjZSBvciBv
bmxpbmUgcmV0YWlsZXJzIGVtYWlsIGxpc3QNCiogRWR1Y2F0aW9uIGluZHVzdHJ5IGV4ZWN1dGl2
ZXMgZW1haWwgbGlzdCAtIFByaW5jaXBhbHMsIERlYW4sDQpBZG1pbnMgYW5kIHRlYWNoZXJzIGZy
b20gU2Nob29scywgQ29sbGVnZXMgYW5kIFVuaXZlcnNpdGllcw0KKiBFbmdpbmVlcnMgZW1haWwg
bGlzdA0KKiBFdmVudCBhbmQgbWVldGluZyBwbGFubmVycyBlbWFpbCBsaXN0DQoqIEZhY2lsaXRp
ZXMgYW5kIG9mZmljZSBtYW5hZ2VyIENvbnRhY3RzDQoqIEdlbmVyYWwgYW5kIGNvcnBvcmF0ZSBj
b3Vuc2VsIGFzIHdlbGwgbGVnYWwgcHJvZmVzc2lvbmFscyBsaXN0DQoqIEdvdmVybm1lbnQgY29u
dHJhY3RvcnMgZW1haWwgbGlzdA0KKiBIZWFsdGggJiBTYWZldHkgQ29udGFjdHMNCiogSGlnaCBu
ZXQgd29ydGggaW5kaXZpZHVhbHMvaW52ZXN0b3JzIGVtYWlsIGxpc3QNCiogSG9zcGl0YWxzLCBj
bGluaWNzLCBwcml2YXRlIHByYWN0aWNlcywgUGhhcm1hY2V1dGljYWwgYW5kDQpiaW90ZWNobm9s
b2d5IGNvbXBhbnnigJlzIHRvcCBkZWNpc2lvbiBtYWtlcnMgZW1haWwgbGlzdA0KKiBIdW1hbiBD
YXBpdGFsIE1hbmFnZW1lbnQgQ29udGFjdHMNCiogSW5kaXZpZHVhbCBpbnN1cmFuY2UgYWdlbnRz
IGxpc3QNCiogSVNWL1ZBUnMgbGlzdA0KKiBMZWFybmluZyAmIERldmVsb3BtZW50IENvbnRhY3Rz
DQoqIExvZ2lzdGljcywgc2hpcHBpbmcgYW5kIHN1cHBseSBjaGFpbiBtYW5hZ2VycyBlbWFpbCBs
aXN0DQoqIE1hbnVmYWN0dXJpbmcgSW5kdXN0cnkgZXhlY3V0aXZlcyBsaXN0DQoqIE5ldHdvcmsg
bWFuYWdlciwgU3VydmVpbGxhbmNlLCBTeXN0ZW0gQWRtaW5pc3RyYXRvciwgVGVjaG5pY2FsDQpT
dXBwb3J0IENvbnRhY3RzDQoqIE5ldyAmIFVzZWQgQ2FyIERlYWxlcnMgZW1haWwgbGlzdA0KKiBP
aWwsIEdhcyBhbmQgdXRpbGl0eSBpbmR1c3RyeSBjb250YWN0cw0KKiBQaHlzaWNpYW5zLCBEb2N0
b3JzLCBOdXJzZXMsIERlbnRpc3RzLCBUaGVyYXBpc3RzIGVtYWlsIGxpc3QNCiogUGxhbnQgTWFu
YWdlciBDb250YWN0cw0KKiBQcm9kdWN0IGFuZCBwcm9qZWN0IG1hbmFnZW1lbnQgbGlzdA0KKiBQ
dXJjaGFzaW5nIGFuZCBQcm9jdXJlbWVudCBDb250YWN0cw0KKiBTcGVjaWZpYyBFdmVudCBhdHRl
bmRlZXMgbGlzdA0KKiBUZWxlY29tIG1hbmFnZXJzLCBWT0lQIG1hbmFnZXJzLCBDbG91ZCBhcmNo
aXRlY3QsIENsb3VkIG1hbmFnZXJzLA0KU3RvcmFnZSBtYW5hZ2VycyBlbWFpbCBsaXN0DQoqIFZQ
L0RpcmVjdG9yL01hbmFnZXIgb2YgQ3VzdG9tZXIgU2VydmljZSBhbmQgQ3VzdG9tZXIgU3VjY2Vz
cw0KVGhhbmtzIGFuZCBsZXQgbWUga25vdy4NClNvcGhpYSBXaWxsaWFtcw0KRGF0YWJhc2UgTWFy
a2V0aW5nDQpVbnN1YnNjcmliZQ0KaHR0cDovL2FwcGVuZGxlYWRlZG0uaW5mby9lbW0vaW5kZXgu
cGhwL2xpc3RzL3NyNjE5NHdweHJlZTQvdW5zdWJzY3JpYmUvcW01NzJyYXM0ZWZmNS9zZTkwMXBu
bHdwMzM2DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
