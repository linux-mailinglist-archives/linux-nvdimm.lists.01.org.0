Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE2D287CA7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Oct 2020 21:53:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88A591544614D;
	Thu,  8 Oct 2020 12:53:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=boris.ostrovsky@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F90D1544614B
	for <linux-nvdimm@lists.01.org>; Thu,  8 Oct 2020 12:53:12 -0700 (PDT)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098JiY01121352;
	Thu, 8 Oct 2020 19:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TOXYoPq7dhn6DY/1xOASv8Mqfnor1vAExhw+DTAwaGY=;
 b=l+BVAMIQHQuI/buil576rcNVLNwOWWg9XHB8Kka1ny5c+3NiQAiu6yGmEmqdDyJrVkIa
 9MgaV1Ri/GwGb3JkAvufPKriR7tEfbgnRq1qEn8Uur1iz3Q9CMdV9Juq76SSP3KcEbRz
 M4IHIZgsD0WhxSzmIfrEA4GW56W3qxW459Vhm0jZBHlKjsRN804PBm7PFqa/XKVRQJqi
 Z6mgNF4EiCMlZjqlRkVn0HVljEhu1zRDQaoJJDUst+C11z1U3UWxzunfjFTnIyIij/Go
 ZThcSZYBoht2G01MamvOOHUAdX+aAmQhyS9w/3NhLRXAeOImUCsJToZVvyr6AfIPhJEC ew==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2130.oracle.com with ESMTP id 33xetb9vxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 08 Oct 2020 19:52:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098JkGT2068959;
	Thu, 8 Oct 2020 19:52:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 33y381mmvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Oct 2020 19:52:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 098JqXsO027511;
	Thu, 8 Oct 2020 19:52:33 GMT
Received: from [10.74.86.78] (/10.74.86.78)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 08 Oct 2020 12:52:32 -0700
Subject: Re: [PATCH v6 09/11] mm/memremap_pages: convert to 'struct range'
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160196733645.2166475.12840692906594512941.stgit@dwillia2-desk3.amr.corp.intel.com>
From: boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <a2a740e2-424c-69ff-45a6-3d71feac5c50@oracle.com>
Date: Thu, 8 Oct 2020 15:52:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160196733645.2166475.12840692906594512941.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080138
Message-ID-Hash: YFQIIZI7PY4HEQIZCMRRGCVWM5PZJA3C
X-Message-ID-Hash: YFQIIZI7PY4HEQIZCMRRGCVWM5PZJA3C
X-MailFrom: boris.ostrovsky@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Dan Carpenter <dan.carpenter@oracle.com>, dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, david@redhat.com, joao.m.martins@oracle.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YFQIIZI7PY4HEQIZCMRRGCVWM5PZJA3C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpPbiAxMC82LzIwIDI6NTUgQU0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gVGhlICdzdHJ1Y3Qg
cmVzb3VyY2UnIGluICdzdHJ1Y3QgZGV2X3BhZ2VtYXAnIGlzIG9ubHkgdXNlZCBmb3IgaG9sZGlu
Zw0KPiByZXNvdXJjZSBzcGFuIGluZm9ybWF0aW9uLiAgVGhlIG90aGVyIGZpZWxkcywgJ25hbWUn
LCAnZmxhZ3MnLCAnZGVzYycsDQo+ICdwYXJlbnQnLCAnc2libGluZycsIGFuZCAnY2hpbGQnIGFy
ZSBhbGwgdW51c2VkIHdhc3RlZCBzcGFjZS4NCj4NCj4gVGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBm
b3IgaW50cm9kdWNpbmcgYSBtdWx0aS1yYW5nZSBleHRlbnNpb24gb2YNCj4gZGV2bV9tZW1yZW1h
cF9wYWdlcygpLg0KPg0KPiBUaGUgYnVsayBvZiB0aGlzIGNoYW5nZSBpcyB1bndpbmRpbmcgYWxs
IHRoZSBwbGFjZXMgaW50ZXJuYWwgdG8gbGlibnZkaW1tDQo+IHRoYXQgdXNlZCAnc3RydWN0IHJl
c291cmNlJyB1bm5lY2Vzc2FyaWx5LCBhbmQgcmVwbGFjaW5nIGluc3RhbmNlcyBvZg0KPiAnc3Ry
dWN0IGRldl9wYWdlbWFwJy5yZXMgd2l0aCAnc3RydWN0IGRldl9wYWdlbWFwJy5yYW5nZS4NCj4N
Cj4gUDJQRE1BIGhhZCBhIG1pbm9yIHVzYWdlIG9mIHRoZSByZXNvdXJjZSBmbGFncyBmaWVsZCwg
YnV0IG9ubHkgdG8gcmVwb3J0DQo+IGZhaWx1cmVzIHdpdGggIiVwUiIuICBUaGF0IGlzIHJlcGxh
Y2VkIHdpdGggYW4gb3BlbiBjb2RlZCBwcmludCBvZiB0aGUNCj4gcmFuZ2UuDQo+DQo+IExpbms6
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMTU5NjQzMTAzMTczLjQwNjIzMDIuNzY4OTk4ODg1
NjkxNzExNTMyLnN0Z2l0QGR3aWxsaWEyLWRlc2szLmFtci5jb3JwLmludGVsLmNvbQ0KPiBMaW5r
OiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMjAwOTI2MTIxNDAyLkdBNzQ2N0BrYWRhbQ0K
PiBDYzogUGF1bCBNYWNrZXJyYXMgPHBhdWx1c0BvemxhYnMub3JnPg0KPiBDYzogTWljaGFlbCBF
bGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1Pg0KPiBDYzogQmVuamFtaW4gSGVycmVuc2NobWlk
dCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPg0KPiBDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwu
bC52ZXJtYUBpbnRlbC5jb20+DQo+IENjOiBWaXZlayBHb3lhbCA8dmdveWFsQHJlZGhhdC5jb20+
DQo+IENjOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IEJlbiBTa2Vn
Z3MgPGJza2VnZ3NAcmVkaGF0LmNvbT4NCj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4NCj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4NCj4gQ2M6IElyYSBX
ZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFz
QGdvb2dsZS5jb20+DQo+IENjOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFj
bGUuY29tPg0KPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiBDYzogU3Rl
ZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPg0KPiBDYzogIkrDqXLDtG1l
IEdsaXNzZSIgPGpnbGlzc2VAcmVkaGF0LmNvbT4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4u
Y2FycGVudGVyQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQoNCkZvciBYZW4gYml0cw0KDQoNClJldmlld2VkLWJ5
OiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
