Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0481AF399
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:46:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1730610FC62CE;
	Sat, 18 Apr 2020 11:46:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=chuck.lever@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2B7A10FC62C5
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:46:33 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IIbvof110170;
	Sat, 18 Apr 2020 18:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=OMbwDKsG/vOO5AAoxKcfs/BIRelllRhJg9DLfQ0cROg=;
 b=XarPKwUMp7eFpqLRIA+E9xQ6HCh/1NBQo9ytJJXL2GWJvERJWITDG8npsHm0A3vtM/23
 AK2WjOnJN8Q+JnFN5kmACcUtBxWi6ByISqRcwrOTWuEZd5g1XrMTALImUQKyGTaASrZY
 c2gTo/F7Rtr2Bb+UaZJkRthP1d7dqHb1BoQFH/ah6DeWtsupMYIUzN7zvmKJF3TetZ6d
 LxI5gemgWLkr8CdWBGY1u6v3vxXBHogEkemzupqaynwk1+E7X7Nv5chOi5dOmEgXULA4
 ejp8E/PSLZXUmu6Thg9uKe42tMoDDyGAOA4OE0x2XWAKh2hrsC/CzOSCEc1P348Xlqib Sw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 30g6dwr26c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2020 18:46:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IIbSC4149674;
	Sat, 18 Apr 2020 18:46:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 30fqka563c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Apr 2020 18:46:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03IIjvac015073;
	Sat, 18 Apr 2020 18:45:57 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Sat, 18 Apr 2020 11:45:57 -0700
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200418184111.13401-7-rdunlap@infradead.org>
Date: Sat, 18 Apr 2020 14:45:55 -0400
Message-Id: <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9595 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004180156
Message-ID-Hash: FC3VYQCVVTDUARUFO45JWVWVE6QBYHOZ
X-Message-ID-Hash: FC3VYQCVVTDUARUFO45JWVWVE6QBYHOZ
X-MailFrom: chuck.lever@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FC3VYQCVVTDUARUFO45JWVWVE6QBYHOZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gQXByIDE4LCAyMDIwLCBhdCAyOjQxIFBNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBGaXggZ2NjIGVtcHR5LWJvZHkgd2FybmluZyB3
aGVuIC1XZXh0cmEgaXMgdXNlZDoNCj4gDQo+IC4uL2ZzL25mc2QvbmZzNHN0YXRlLmM6Mzg5ODoz
OiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBhbiDigJhlbHNl
4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBMaW51cyBUb3J2YWxkcyA8dG9y
dmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogIkouIEJydWNlIEZpZWxkcyIgPGJmaWVsZHNAZmll
bGRzZXMub3JnPg0KPiBDYzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+
IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQoNCkkgaGF2ZSBhIHBhdGNoIGluIG15IHF1
ZXVlIHRoYXQgYWRkcmVzc2VzIHRoaXMgcGFydGljdWxhciB3YXJuaW5nLA0KYnV0IHlvdXIgY2hh
bmdlIHdvcmtzIGZvciBtZSB0b28uDQoNCkFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4NCg0KVW5sZXNzIEJydWNlIG9iamVjdHMuDQoNCg0KPiAtLS0NCj4gZnMv
bmZzZC9uZnM0c3RhdGUuYyB8ICAgIDMgKystDQo+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IC0tLSBsaW51eC1uZXh0LTIwMjAwNDE3Lm9yaWcv
ZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiArKysgbGludXgtbmV4dC0yMDIwMDQxNy9mcy9uZnNkL25m
czRzdGF0ZS5jDQo+IEBAIC0zNCw2ICszNCw3IEBADQo+IA0KPiAjaW5jbHVkZSA8bGludXgvZmls
ZS5oPg0KPiAjaW5jbHVkZSA8bGludXgvZnMuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwu
aD4NCj4gI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L25hbWVpLmg+
DQo+ICNpbmNsdWRlIDxsaW51eC9zd2FwLmg+DQo+IEBAIC0zODk1LDcgKzM4OTYsNyBAQCBuZnNk
NF9zZXRjbGllbnRpZChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwDQo+IAkJY29weV9jbGlkKG5ldywg
Y29uZik7DQo+IAkJZ2VuX2NvbmZpcm0obmV3LCBubik7DQo+IAl9IGVsc2UgLyogY2FzZSA0IChu
ZXcgY2xpZW50KSBvciBjYXNlcyAyLCAzIChjbGllbnQgcmVib290KTogKi8NCj4gLQkJOw0KPiAr
CQlkb19lbXB0eSgpOw0KPiAJbmV3LT5jbF9taW5vcnZlcnNpb24gPSAwOw0KPiAJZ2VuX2NhbGxi
YWNrKG5ldywgc2V0Y2xpZCwgcnFzdHApOw0KPiAJYWRkX3RvX3VuY29uZmlybWVkKG5ldyk7DQoN
Ci0tDQpDaHVjayBMZXZlcg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
