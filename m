Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24531B234
	for <lists+linux-nvdimm@lfdr.de>; Sun, 14 Feb 2021 20:22:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6EA05100EBBCE;
	Sun, 14 Feb 2021 11:22:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jejb@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42EB0100EC1E9
	for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 11:21:57 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11EJ2Rjv004234;
	Sun, 14 Feb 2021 14:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=2HSfs+PHnEoAspVggOn3BgvrrXw9WRy1/NNpdkKxiCQ=;
 b=AZF0XAteS7BybRomRYX1JsIb2ozox9iZcsuANYL0RXt1DOGpH5dDZncHkhOo1MmCqO6N
 bN9wDwYuysQC6qwZbZvf0iJ5XmeNG1OR+xeJIVS2mYsLLxHM6iTaq0y08eK4tADF0CEA
 fkKoOtagmhJTVKNKvvgmVoCVGUffCCrVq0F4GQp/Z4xrqebHU1nVIEsLWO+HWe+bCS6r
 bxMHJhhpU5/ixYri+C6GmE6c9iFjLYxsnQtsC23Dv5jV6sm/gZX8ewVelDj99njvNoVd
 /xsREIEyrQHhgvKq8L1FVYyY6/sCJqI4CmD3ZR5qi97i+5qF8aX1c+uVIqwzH+Ok2HJK Dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 36q9nk09b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Feb 2021 14:21:13 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11EJ2LTu003594;
	Sun, 14 Feb 2021 14:21:12 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 36q9nk09ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Feb 2021 14:21:12 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11EJHkRa014564;
	Sun, 14 Feb 2021 19:21:11 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma04wdc.us.ibm.com with ESMTP id 36p6d8j9rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Feb 2021 19:21:11 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11EJLAVZ11862324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Feb 2021 19:21:10 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B369B7805E;
	Sun, 14 Feb 2021 19:21:10 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 372EB7805C;
	Sun, 14 Feb 2021 19:21:04 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Sun, 14 Feb 2021 19:21:03 +0000 (GMT)
Message-ID: <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From: James Bottomley <jejb@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>
Date: Sun, 14 Feb 2021 11:21:02 -0800
In-Reply-To: <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
References: <20210214091954.GM242749@kernel.org>
	 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-14_06:2021-02-12,2021-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=828 clxscore=1015
 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102140159
Message-ID-Hash: MSWHR3YGQPOKHG54HIZMF5IYGTH7JASA
X-Message-ID-Hash: MSWHR3YGQPOKHG54HIZMF5IYGTH7JASA
X-MailFrom: jejb@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will
 @kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: jejb@linux.ibm.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MSWHR3YGQPOKHG54HIZMF5IYGTH7JASA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCAyMDIxLTAyLTE0IGF0IDEwOjU4ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNClsuLi5dDQo+ID4gQW5kIGhlcmUgd2UgY29tZSB0byB0aGUgcXVlc3Rpb24gIndoYXQgYXJl
IHRoZSBkaWZmZXJlbmNlcyB0aGF0DQo+ID4ganVzdGlmeSBhIG5ldyBzeXN0ZW0gY2FsbD8iIGFu
ZCB0aGUgYW5zd2VyIHRvIHRoaXMgaXMgdmVyeQ0KPiA+IHN1YmplY3RpdmUuIEFuZCBhcyBzdWNo
IHdlIGNhbiBjb250aW51ZSBiaWtlc2hlZGRpbmcgZm9yZXZlci4NCj4gDQo+IEkgdGhpbmsgdGhp
cyBmaXRzIGludG8gdGhlIGV4aXN0aW5nIG1lbWZkX2NyZWF0ZSgpIHN5c2NhbGwganVzdCBmaW5l
LA0KPiBhbmQgSSBoZWFyZCBubyBjb21wZWxsaW5nIGFyZ3VtZW50IHdoeSBpdCBzaG91bGRu4oCY
dC4gVGhhdOKAmHMgYWxsIEkgY2FuDQo+IHNheS4NCg0KT0ssIHNvIGxldCdzIHJldmlldyBoaXN0
b3J5LiAgSW4gdGhlIGZpcnN0IHR3byBpbmNhcm5hdGlvbnMgb2YgdGhlDQpwYXRjaCwgaXQgd2Fz
IGFuIGV4dGVuc2lvbiBvZiBtZW1mZF9jcmVhdGUoKS4gIFRoZSBzcGVjaWZpYyBvYmplY3Rpb24N
CmJ5IEtpcmlsbCBTaHV0ZW1vdiB3YXMgdGhhdCBpdCBkb2Vzbid0IHNoYXJlIGFueSBjb2RlIGlu
IGNvbW1vbiB3aXRoDQptZW1mZCBhbmQgc28gc2hvdWxkIGJlIGEgc2VwYXJhdGUgc3lzdGVtIGNh
bGw6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWFwaS8yMDIwMDcxMzEwNTgxMi5k
bnd0ZGhzdXlqM3hiaDRmQGJveC8NCg0KVGhlIG90aGVyIG9iamVjdGlvbiByYWlzZWQgb2ZmbGlz
dCBpcyB0aGF0IGlmIHdlIGRvIHVzZSBtZW1mZF9jcmVhdGUsDQp0aGVuIHdlIGhhdmUgdG8gYWRk
IGFsbCB0aGUgc2VjcmV0IG1lbW9yeSBmbGFncyBhcyBhbiBhZGRpdGlvbmFsIGlvY3RsLA0Kd2hl
cmVhcyB0aGV5IGNhbiBiZSBzcGVjaWZpZWQgb24gb3BlbiBpZiB3ZSBkbyBhIHNlcGFyYXRlIHN5
c3RlbSBjYWxsLiANClRoZSBjb250YWluZXIgcGVvcGxlIHZpb2xlbnRseSBvYmplY3RlZCB0byB0
aGUgaW9jdGwgYmVjYXVzZSBpdCBjYW4ndA0KYmUgcHJvcGVybHkgYW5hbHlzZWQgYnkgc2VjY29t
cCBhbmQgbXVjaCBwcmVmZXJyZWQgdGhlIHN5c2NhbGwgdmVyc2lvbi4NCg0KU2luY2Ugd2UncmUg
ZHVtcGluZyB0aGUgdW5jYWNoZWQgdmFyaWFudCwgdGhlIGlvY3RsIHByb2JsZW0gZGlzYXBwZWFy
cw0KYnV0IHNvIGRvZXMgdGhlIHBvc3NpYmlsaXR5IG9mIGV2ZXIgYWRkaW5nIGl0IGJhY2sgaWYg
d2UgdGFrZSBvbiB0aGUNCmNvbnRhaW5lciBwZW9wbGVzJyBvYmplY3Rpb24uICBUaGlzIGFyZ3Vl
cyBmb3IgYSBzZXBhcmF0ZSBzeXNjYWxsDQpiZWNhdXNlIHdlIGNhbiBhZGQgYWRkaXRpb25hbCBm
ZWF0dXJlcyBhbmQgZXh0ZW5kIHRoZSBBUEkgd2l0aCBmbGFncw0Kd2l0aG91dCBjYXVzaW5nIGFu
dGktaW9jdGwgcmlvdHMuDQoNCkphbWVzDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
