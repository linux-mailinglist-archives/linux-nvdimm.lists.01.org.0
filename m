Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD492EF71C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Jan 2021 19:15:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E52D100F225A;
	Fri,  8 Jan 2021 10:15:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E270100EC1D5
	for <linux-nvdimm@lists.01.org>; Fri,  8 Jan 2021 10:15:22 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108HwwOY004690;
	Fri, 8 Jan 2021 18:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KiTw25sQnwXSQX+0iRD1HBB4uXxJXhd7Tk5XQ9JUJTE=;
 b=gTJvSGLjyueTzS8vgNsV+rpKJmQFk8fY+zb3p5ZDQqfAWD0TXtxr0+zcwpk/Z5f9BG5e
 VwNDwsqFMNUcseD6IEwkpfpSHYOITZNUp5dTFJF3GZJlV0Qbvj5cXNFfUWQ4mhZbb6Kh
 7t601GM0mXU18dnI2cVo1qytEC2sUIBJA6/fu4DmcG+wxp0PxPmrBAwkqYTHm9KeCfXv
 FqcIB4Ec7M+DYaIHNVo1oCCjPzOaZ1lgAMjgQF/f8urKsNVcjV12MvAhvgmFwrWXDi2x
 SFEINWClUGqtHlOWAU9dapkOdg1gHd2jiFKW+9gf1IC+ZJpceqxWihAQYrpFIpewNTLj zg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 35wcuy2pbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 08 Jan 2021 18:15:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108I0wFn081682;
	Fri, 8 Jan 2021 18:15:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 35v1fcvpaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Jan 2021 18:15:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 108IF6J1019818;
	Fri, 8 Jan 2021 18:15:06 GMT
Received: from [10.159.230.21] (/10.159.230.21)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 08 Jan 2021 18:15:05 +0000
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
 <20201218034907.GG6918@magnolia>
 <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <f3f93809-ba68-521f-70d8-27f1ba5d0036@oracle.com>
Date: Fri, 8 Jan 2021 10:14:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080099
Message-ID-Hash: I5FQHH2UP544IXIANDM2NKNQKQCLEIYC
X-Message-ID-Hash: I5FQHH2UP544IXIANDM2NKNQKQCLEIYC
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I5FQHH2UP544IXIANDM2NKNQKQCLEIYC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGksIFNoaXlhbmcsDQoNCk9uIDEyLzE4LzIwMjAgMToxMyBBTSwgUnVhbiBTaGl5YW5nIHdyb3Rl
Og0KPj4+Pg0KPj4+PiBTbyBJIHRyaWVkIHRoZSBwYXRjaHNldCB3aXRoIHBtZW0gZXJyb3IgaW5q
ZWN0aW9uLCB0aGUgU0lHQlVTIHBheWxvYWQNCj4+Pj4gZG9lcyBub3QgbG9vayByaWdodCAtDQo+
Pj4+DQo+Pj4+ICoqIFNJR0JVUyg3KTogKioNCj4+Pj4gKiogc2lfYWRkcigweChuaWwpKSwgc2lf
bHNiKDB4QyksIHNpX2NvZGUoMHg0LCBCVVNfTUNFRVJSX0FSKSAqKg0KPj4+Pg0KPj4+PiBJIGV4
cGVjdCB0aGUgcGF5bG9hZCBsb29rcyBsaWtlDQo+Pj4+DQo+Pj4+ICoqIHNpX2FkZHIoMHg3ZjM2
NzJlMDAwMDApLCBzaV9sc2IoMHgxNSksIHNpX2NvZGUoMHg0LCANCj4+Pj4gQlVTX01DRUVSUl9B
UikgKioNCj4+Pg0KPj4+IFRoYW5rcyBmb3IgdGVzdGluZy7CoCBJIHRlc3QgdGhlIFNJR0JVUyBi
eSB3cml0aW5nIGEgcHJvZ3JhbSB3aGljaCBjYWxscw0KPj4+IG1hZHZpc2UoLi4uICxNQURWX0hX
UE9JU09OKSB0byBpbmplY3QgbWVtb3J5LWZhaWx1cmUuwqAgSXQganVzdCBzaG93cyANCj4+PiB0
aGF0DQo+Pj4gdGhlIHByb2dyYW0gaXMga2lsbGVkIGJ5IFNJR0JVUy7CoCBJIGNhbm5vdCBnZXQg
YW55IGRldGFpbCBmcm9tIGl0LsKgIFNvLA0KPj4+IGNvdWxkIHlvdSBwbGVhc2Ugc2hvdyBtZSB0
aGUgcmlnaHQgd2F5KHRlc3QgdG9vbHMpIHRvIHRlc3QgaXQ/DQo+Pg0KPj4gSSdtIGFzc3VtaW5n
IHRoYXQgSmFuZSBpcyB1c2luZyBhIHByb2dyYW0gdGhhdCBjYWxscyBzaWdhY3Rpb24gdG8NCj4+
IGluc3RhbGwgYSBTSUdCVVMgaGFuZGxlciwgYW5kIGR1bXBzIHRoZSBlbnRpcmUgc2lnaW5mb190
IHN0cnVjdHVyZQ0KPj4gd2hlbmV2ZXIgaXQgcmVjZWl2ZXMgb25lLi4uDQoNClllcywgdGhhbmtz
IERhcnJpY2suDQoNCj4gDQo+IE9LLsKgIExldCBtZSB0cnkgaXQgYW5kIGZpZ3VyZSBvdXQgd2hh
dCdzIHdyb25nIGluIGl0Lg0KDQpJIGluamVjdGVkIHBvaXNvbiB2aWEgIm5kY3RsIGluamVjdC1l
cnJvciIsICBub3QgZXhwZWN0aW5nIGl0IG1hZGUgYW55IA0KZGlmZmVyZW5jZSB0aG91Z2guDQoN
CkFueSBsdWNrPw0KDQp0aGFua3MsDQotamFuZQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
