Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4BC31C13B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 19:15:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 048E1100EB856;
	Mon, 15 Feb 2021 10:15:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=jejb@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6AB19100EBBBD
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 10:15:21 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FI3keQ089147;
	Mon, 15 Feb 2021 13:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=oGpfBMoJflzNtTxXhAAqknfbJZwwOWhWibJHXOD15mY=;
 b=B/bnia+10Cs1nS5Q/upnquv2ZqXghmk3a6oXvIJu1bYAT9fq48cugx6TbeiTQlsj7qZM
 r9narncQVfykPHEyJHuo45qRrCnDhJP4fLWXNTzh+wRkWX5CekXlUGk5CLJznaZt6huP
 QS1lVTZ4HiwSm6Zccy5axTKKb4qK9kdk4mVKgXfsgW4HArxGrxT1EA/Pn6mTps4Vjfvm
 m0YOQFc0aWwzXwNK3mVbIys228lxpSUTYg08cJcpzpHT4PcHyChXHf6by4iByZs77BV9
 yKmIzsatDpKh4JWGLHQGoDjjCqXOeQXIJU15C840vpqciQ/nRrzDNGV2nbGbjXU11G1r lA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 36qww5gb83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Feb 2021 13:14:55 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FI4Lrj090689;
	Mon, 15 Feb 2021 13:14:54 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0b-001b2d01.pphosted.com with ESMTP id 36qww5gb7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Feb 2021 13:14:54 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FICq9U024338;
	Mon, 15 Feb 2021 18:14:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma02dal.us.ibm.com with ESMTP id 36p6d9d37g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Feb 2021 18:14:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FIEph216515450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Feb 2021 18:14:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21B67806A;
	Mon, 15 Feb 2021 18:14:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA8027805E;
	Mon, 15 Feb 2021 18:14:44 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 15 Feb 2021 18:14:44 +0000 (GMT)
Message-ID: <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From: James Bottomley <jejb@linux.ibm.com>
To: Michal Hocko <mhocko@suse.com>
Date: Mon, 15 Feb 2021 10:14:43 -0800
In-Reply-To: <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
	 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
	 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
	 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_14:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150137
Message-ID-Hash: HMWAOIATDOOEIKZ74GXFBEVVA7HN4EK6
X-Message-ID-Hash: HMWAOIATDOOEIKZ74GXFBEVVA7HN4EK6
X-MailFrom: jejb@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: jejb@linux.ibm.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HMWAOIATDOOEIKZ74GXFBEVVA7HN4EK6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDIxLTAyLTE1IGF0IDEwOjEzICswMTAwLCBNaWNoYWwgSG9ja28gd3JvdGU6DQo+
IE9uIFN1biAxNC0wMi0yMSAxMToyMTowMiwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+IE9u
IFN1biwgMjAyMS0wMi0xNCBhdCAxMDo1OCArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6
DQo+ID4gWy4uLl0NCj4gPiA+ID4gQW5kIGhlcmUgd2UgY29tZSB0byB0aGUgcXVlc3Rpb24gIndo
YXQgYXJlIHRoZSBkaWZmZXJlbmNlcyB0aGF0DQo+ID4gPiA+IGp1c3RpZnkgYSBuZXcgc3lzdGVt
IGNhbGw/IiBhbmQgdGhlIGFuc3dlciB0byB0aGlzIGlzIHZlcnkNCj4gPiA+ID4gc3ViamVjdGl2
ZS4gQW5kIGFzIHN1Y2ggd2UgY2FuIGNvbnRpbnVlIGJpa2VzaGVkZGluZyBmb3JldmVyLg0KPiA+
ID4gDQo+ID4gPiBJIHRoaW5rIHRoaXMgZml0cyBpbnRvIHRoZSBleGlzdGluZyBtZW1mZF9jcmVh
dGUoKSBzeXNjYWxsIGp1c3QNCj4gPiA+IGZpbmUsIGFuZCBJIGhlYXJkIG5vIGNvbXBlbGxpbmcg
YXJndW1lbnQgd2h5IGl0IHNob3VsZG7igJh0LiBUaGF04oCYcw0KPiA+ID4gYWxsIEkgY2FuIHNh
eS4NCj4gPiANCj4gPiBPSywgc28gbGV0J3MgcmV2aWV3IGhpc3RvcnkuICBJbiB0aGUgZmlyc3Qg
dHdvIGluY2FybmF0aW9ucyBvZiB0aGUNCj4gPiBwYXRjaCwgaXQgd2FzIGFuIGV4dGVuc2lvbiBv
ZiBtZW1mZF9jcmVhdGUoKS4gIFRoZSBzcGVjaWZpYw0KPiA+IG9iamVjdGlvbiBieSBLaXJpbGwg
U2h1dGVtb3Ygd2FzIHRoYXQgaXQgZG9lc24ndCBzaGFyZSBhbnkgY29kZSBpbg0KPiA+IGNvbW1v
biB3aXRoIG1lbWZkIGFuZCBzbyBzaG91bGQgYmUgYSBzZXBhcmF0ZSBzeXN0ZW0gY2FsbDoNCj4g
PiANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcGkvMjAyMDA3MTMxMDU4MTIu
ZG53dGRoc3V5ajN4Ymg0ZkBib3gvDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBwb2ludGVyLiBCdXQg
dGhpcyBhcmd1bWVudCBoYXNuJ3QgYmVlbiBjaGFsbGVuZ2VkIGF0DQo+IGFsbC4gSXQgaGFzbid0
IGJlZW4gYnJvdWdodCB1cCB0aGF0IHRoZSBvdmVybGFwIHdvdWxkIGJlIGNvbnNpZGVyYWJsZQ0K
PiBoaWdoZXIgYnkgdGhlIGh1Z2V0bGIvc2VhbGluZyBzdXBwb3J0LiBBbmQgc28gZmFyIG5vYm9k
eSBoYXMgY2xhaW1lZA0KPiB0aG9zZSBjb21iaW5hdGlvbnMgYXMgdW52aWFibGUuDQoNCktpcmls
bCBpcyBhY3R1YWxseSBpbnRlcmVzdGVkIGluIHRoZSBzZWFsaW5nIHBhdGggZm9yIGhpcyBLVk0g
Y29kZSBzbw0Kd2UgdG9vayBhIGxvb2suICBUaGVyZSBtaWdodCBiZSBhIHR3byBsaW5lIG92ZXJs
YXAgaW4gbWVtZmRfY3JlYXRlIGZvcg0KdGhlIHNlYWwgY2FzZSwgYnV0IHRoZXJlJ3Mgbm8gcmVh
bCBvdmVybGFwIGluIG1lbWZkX2FkZF9zZWFscyB3aGljaCBpcw0KdGhlIGJ1bGsgb2YgdGhlIGNv
ZGUuICBTbyB0aGUgYmVzdCB3YXkgd291bGQgc2VlbSB0byBsaWZ0IHRoZSBpbm9kZSAuLi4NCi0+
IHNlYWxzIGhlbHBlcnMgdG8gYmUgbm9uLXN0YXRpYyBzbyB0aGV5IGNhbiBiZSByZXVzZWQgYW5k
IHJvbGwgb3VyDQpvd24gYWRkX3NlYWxzLg0KDQpJIGNhbid0IHNlZSBhIHVzZSBjYXNlIGF0IGFs
bCBmb3IgaHVnZXRsYiBzdXBwb3J0LCBzbyBpdCBzZWVtcyB0byBiZSBhDQpiaXQgb2YgYW4gYW5n
ZWxzIG9uIHBpbiBoZWFkIGRpc2N1c3Npb24uICBIb3dldmVyLCBpZiBvbmUgd2VyZSB0byBjb21l
DQphbG9uZyBoYW5kbGluZyBpdCBpbiB0aGUgc2FtZSB3YXkgc2VlbXMgcmVhc29uYWJsZS4NCg0K
PiA+IFRoZSBvdGhlciBvYmplY3Rpb24gcmFpc2VkIG9mZmxpc3QgaXMgdGhhdCBpZiB3ZSBkbyB1
c2UNCj4gPiBtZW1mZF9jcmVhdGUsIHRoZW4gd2UgaGF2ZSB0byBhZGQgYWxsIHRoZSBzZWNyZXQg
bWVtb3J5IGZsYWdzIGFzIGFuDQo+ID4gYWRkaXRpb25hbCBpb2N0bCwgd2hlcmVhcyB0aGV5IGNh
biBiZSBzcGVjaWZpZWQgb24gb3BlbiBpZiB3ZSBkbyBhDQo+ID4gc2VwYXJhdGUgc3lzdGVtIGNh
bGwuICBUaGUgY29udGFpbmVyIHBlb3BsZSB2aW9sZW50bHkgb2JqZWN0ZWQgdG8NCj4gPiB0aGUg
aW9jdGwgYmVjYXVzZSBpdCBjYW4ndCBiZSBwcm9wZXJseSBhbmFseXNlZCBieSBzZWNjb21wIGFu
ZCBtdWNoDQo+ID4gcHJlZmVycmVkIHRoZSBzeXNjYWxsIHZlcnNpb24uDQo+ID4gDQo+ID4gU2lu
Y2Ugd2UncmUgZHVtcGluZyB0aGUgdW5jYWNoZWQgdmFyaWFudCwgdGhlIGlvY3RsIHByb2JsZW0N
Cj4gPiBkaXNhcHBlYXJzIGJ1dCBzbyBkb2VzIHRoZSBwb3NzaWJpbGl0eSBvZiBldmVyIGFkZGlu
ZyBpdCBiYWNrIGlmIHdlDQo+ID4gdGFrZSBvbiB0aGUgY29udGFpbmVyIHBlb3BsZXMnIG9iamVj
dGlvbi4gIFRoaXMgYXJndWVzIGZvciBhDQo+ID4gc2VwYXJhdGUgc3lzY2FsbCBiZWNhdXNlIHdl
IGNhbiBhZGQgYWRkaXRpb25hbCBmZWF0dXJlcyBhbmQgZXh0ZW5kDQo+ID4gdGhlIEFQSSB3aXRo
IGZsYWdzIHdpdGhvdXQgY2F1c2luZyBhbnRpLWlvY3RsIHJpb3RzLg0KPiANCj4gSSBhbSBzb3Jy
eSBidXQgSSBkbyBub3QgdW5kZXJzdGFuZCB0aGlzIGFyZ3VtZW50Lg0KDQpZb3UgZG9uJ3QgdW5k
ZXJzdGFuZCB3aHkgY29udGFpbmVyIGd1YXJkaW5nIHRlY2hub2xvZ3kgZG9lc24ndCBsaWtlDQpp
b2N0bHM/ICBUaGUgcHJvYmxlbSBpcyBlYWNoIGlvY3RsIGlzIHRoZSBtdWx0aXBsZXhvciBpcyBz
cGVjaWZpYyB0bw0KdGhlIHBhcnRpY3VsYXIgZmQgaW1wbGVtZW50YXRpb24sIHNvIHVubGlrZSBm
Y250bCB5b3UgZG9uJ3QgaGF2ZSBnbG9iYWwNCmlvY3RsIG51bWJlcnMgKGFsdGhvdWdoIHdlIGRv
IHRyeSB0byBzZXBhcmF0ZSB0aGUgc3BhY2Ugc29tZXdoYXQgd2l0aA0KdGhlIF9JTyBtYWNyb3Mp
LiAgVGhpcyBtYWtlcyBhbmFseXNpcyBhbmQgYmxvY2tpbmcgYSBoYXJkIHByb2JsZW0gZm9yDQpj
b250YWluZXIgc2VjY29tcC4NCg0KPiAgV2hhdCBraW5kIG9mIGZsYWdzIGFyZSB3ZSB0YWxraW5n
IGFib3V0IGFuZCB3aHkgd291bGQgdGhhdCBiZSBhDQo+IHByb2JsZW0gd2l0aCBtZW1mZF9jcmVh
dGUgaW50ZXJmYWNlPyBDb3VsZCB5b3UgYmUgbW9yZSBzcGVjaWZpYw0KPiBwbGVhc2U/DQoNCllv
dSBtZWFuIHdoYXQgd2VyZSB0aGUgaW9jdGwgZmxhZ3MgaW4gdGhlIHBhdGNoIHNlcmllcyBsaW5r
ZWQgYWJvdmU/IA0KVGhleSB3ZXJlIFNFQ1JFVE1FTV9FWENMVVNJVkUgYW5kIFNFQ1JFVE1FTV9V
TkNBQ0hFRCBpbiBwYXRjaCAzLzUuIA0KVGhleSB3ZXJlIGV2ZW50dWFsbHkgZHJvcHBlZCBhZnRl
ciB2MTAsIGJlY2F1c2Ugb2YgcHJvYmxlbXMgd2l0aA0KYXJjaGl0ZWN0dXJhbCBzZW1hbnRpY3Ms
IHdpdGggdGhlIGlkZWEgdGhhdCBpdCBjb3VsZCBiZSBhZGRlZCBiYWNrDQphZ2FpbiBpZiBhIGNv
bXBlbGxpbmcgbmVlZCBhcm9zZToNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYXBp
LzIwMjAxMTIzMDk1NDMyLjU4NjAtMS1ycHB0QGtlcm5lbC5vcmcvDQoNCkluIHRoZW9yeSB0aGUg
ZXh0cmEgZmxhZ3MgY291bGQgYmUgbXVsdGlwbGV4ZWQgaW50byB0aGUgbWVtZmRfY3JlYXRlDQpm
bGFncyBsaWtlIGh1Z2V0bGJmcyBpcyBidXQgd2l0aCAzMiBmbGFncyBhbmQgYSBsb3QgYWxyZWFk
eSB0YWtlbiBpdA0KZ2V0cyBtZXNzeSBmb3IgZXhwYW5zaW9uLiAgV2hlbiB3ZSBydW4gb3V0IG9m
IGZsYWdzIHRoZSBmaXJzdCBxdWVzdGlvbg0KcGVvcGxlIHdpbGwgYXNrIGlzICJ3aHkgZGlkbid0
IHlvdSBkbyBzZXBhcmF0ZSBzeXN0ZW0gY2FsbHM/Ii4NCg0KSmFtZXMNCg0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
