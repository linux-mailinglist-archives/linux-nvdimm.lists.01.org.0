Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2C23AF7E
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 23:12:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7AC6129E8142;
	Mon,  3 Aug 2020 14:12:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 52671129E8142
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 14:12:17 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073LC5Aj155693;
	Mon, 3 Aug 2020 21:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=coPlDp690bVQKrb6CgS9uUoXxxJcdWaAyy5rOJSG0HM=;
 b=q2T67BfyWrRvIyCoyKQjU6vzRXQ3Tox/4eS6Jx+x2ekBHmLHkDEngbBmZid/mZdHGoVG
 QOziUzwm/obj/ygJBlywfENFUjsNE/4CMGLmyoR/FncUq+0BOSz08E2w/5NKJzFJLADC
 /ZPv5as1Z1sUiSSQzWHMdCuXf3zY4Bt7jArYCnvnp2MRivFfMZoPlKfKtjEbZe6JBMoQ
 x6xMmS0qoYOIkg5qVaL9eYPzrk41mdgmRxd+q4DKB5bfShK/I8WH6S2eBROFIitncXbZ
 1xJ6vjtle/glQNwfAFuPvnyan/lxujVQ8G7iduL5zhtqSFvgNHB+Beq7csiCR/9Vcbgn Cg==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 32n11n0r9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2020 21:12:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073L8tLg176648;
	Mon, 3 Aug 2020 21:10:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 32pdhb054u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2020 21:10:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073LADtD008707;
	Mon, 3 Aug 2020 21:10:13 GMT
Received: from [10.159.240.44] (/10.159.240.44)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 03 Aug 2020 14:10:13 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To: Dave Jiang <dave.jiang@intel.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <73f2eadf-3377-db62-ebd1-1eff99d4842e@oracle.com>
Date: Mon, 3 Aug 2020 14:10:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030147
Message-ID-Hash: 5T4DICQR3HTALBE6MIFRAS6NY2EL733W
X-Message-ID-Hash: 5T4DICQR3HTALBE6MIFRAS6NY2EL733W
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5T4DICQR3HTALBE6MIFRAS6NY2EL733W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGksIERhdmUsDQoNCk9uIDgvMy8yMDIwIDE6NDEgUE0sIERhdmUgSmlhbmcgd3JvdGU6DQo+IE9u
IDcvMjQvMjAyMCA5OjA5IEFNLCBKYW5lIENodSB3cm90ZToNCj4+IFNpbmNlDQo+PiBjb21taXQg
ZDc4YzYyMGEyZTgyICgibGlibnZkaW1tL3NlY3VyaXR5OiBJbnRyb2R1Y2UgYSAnZnJvemVuJyAN
Cj4+IGF0dHJpYnV0ZSIpLA0KPj4gd2hlbiBpc3N1ZQ0KPj4gwqAgIyBuZGN0bCBzYW5pdGl6ZS1k
aW1tIG5tZW0wIC0tb3ZlcndyaXRlDQo+PiB0aGVuIGltbWVkaWF0ZWx5IGNoZWNrIHRoZSAnc2Vj
dXJpdHknIGF0dHJpYnV0ZSwNCj4+IMKgICMgY2F0IA0KPj4gL3N5cy9kZXZpY2VzL0xOWFNZU1RN
OjAwL0xOWFNZQlVTOjAwL0FDUEkwMDEyOjAwL25kYnVzMC9ubWVtMC9zZWN1cml0eQ0KPj4gwqAg
dW5sb2NrZWQNCj4+IEFjdHVhbGx5IHRoZSBhdHRyaWJ1dGUgc3RheXMgJ3VubG9ja2VkJyB0aHJv
dWdoIG91dCB0aGUgZW50aXJlIG92ZXJ3cml0ZQ0KPj4gb3BlcmF0aW9uLCBuZXZlciBjaGFuZ2Vk
LsKgIFRoYXQncyBiZWNhdXNlICdudmRpbW0tPnNlYy5mbGFncycgaXMgYSBiaXRtYXANCj4+IHRo
YXQgaGFzIGJvdGggYml0cyBzZXQgaW5kaWNhdGluZyAnb3ZlcndyaXRlJyBhbmQgJ3VubG9ja2Vk
Jy4NCj4+IEJ1dCBzZWN1cml0eV9zaG93KCkgY2hlY2tzIHRoZSBtdXR1YWxseSBleGNsdXNpdmUg
Yml0cyBiZWZvcmUgaXQgY2hlY2tzDQo+PiB0aGUgJ292ZXJ3cml0ZScgYml0IGF0IGxhc3QuIFRo
ZSBvcmRlciBzaG91bGQgYmUgcmV2ZXJzZWQuDQo+Pg0KPj4gVGhlIGNvbW1pdCBhbHNvIGhhcyBh
IHR5cG86IGluIG9uZSBvY2Nhc2lvbiwgJ252ZGltbS0+c2VjLmV4dF9zdGF0ZScNCj4+IGFzc2ln
bm1lbnQgaXMgcmVwbGFjZWQgd2l0aCAnbnZkaW1tLT5zZWMuZmxhZ3MnIGFzc2lnbm1lbnQgZm9y
DQo+PiB0aGUgTlZESU1NX01BU1RFUiB0eXBlLg0KPiANCj4gTWF5IGJlIGJlc3QgdG8gc3BsaXQg
dGhpcyBmaXggdG8gYSBkaWZmZXJlbnQgcGF0Y2g/IEp1c3QgdGhpbmtpbmcgZ2l0IA0KPiBiaXNl
Y3QgbGF0ZXIgb24gdG8gdHJhY2sgaXNzdWVzLiBPdGhlcndpc2UgUmV2aWV3ZWQtYnk6IERhdmUg
SmlhbmcgDQo+IDxkYXZlLmppYW5nQGludGVsLmNvbT4NCg0KU3VyZS4gSSB0YWtlIGl0IHlvdSBt
ZWFudCB0byBzZXBhcmF0ZSB0aGUgdHlwbyBmaXggZnJvbSB0aGUgY2hhbmdlIHRoYXQgDQp0ZXN0
cyB0aGUgT1ZFUldSSVRFIGJpdCBmaXJzdD8NCg0KUmVnYXJkcywNCi1qYW5lCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
