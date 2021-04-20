Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E823659AD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 15:17:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BAA32100EB35B;
	Tue, 20 Apr 2021 06:17:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70276100EB358
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 06:17:14 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE057613CA;
	Tue, 20 Apr 2021 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618924634;
	bh=I/WWp3ZhiKpLexAP/6uikhopmlNfpvxqz9r1ZOciMHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjXkKne+FA6PkCeeaRcCEbX6RLKVRuOZ950ZCFbmq7MKlDrFMoTQh9mnZRkPy2aGx
	 /gLjaLVwUrA1Rp2N6jWx+BpEIWTFmBe1vqlBsoiPGg0GkiVz5tLIB0gsurVKD4pkaw
	 7gXvNEn04SUiRgGDfrhEgpO4bnMBzvJNM0M7y6t+/VENHx8C/E9ulvt5AmJqWDUUQn
	 zKcjUrgm6zeqJrE/wb8pbdExYJ3d26l9AX4v5MOq3N/1HlIm+936DGGRA0IZdnoFfM
	 VLSUXFbe7czTs8sXSG+NXGS+jKF3NMjIzssHmIppiVUWTlLNzvGw0BLAO7qZijhlnW
	 CdBL8LeCbxZ3w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] secretmem: optimize page_is_secretmem()
Date: Tue, 20 Apr 2021 16:16:11 +0300
Message-Id: <20210420131611.8259-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210420131611.8259-1-rppt@kernel.org>
References: <20210420131611.8259-1-rppt@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: WBC4DMLBI2FVF5ZEAGD55G2PTVAY2KDO
X-Message-ID-Hash: WBC4DMLBI2FVF5ZEAGD55G2PTVAY2KDO
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel B
 utt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WBC4DMLBI2FVF5ZEAGD55G2PTVAY2KDO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KDQpLZXJuZWwgdGVzdCBy
b2JvdCByZXBvcnRlZCAtNC4yJSByZWdyZXNzaW9uIG9mIHdpbGwtaXQtc2NhbGUucGVyX3RocmVh
ZF9vcHMNCmR1ZSB0byBjb21taXQgIm1tOiBpbnRyb2R1Y2UgbWVtZmRfc2VjcmV0IHN5c3RlbSBj
YWxsIHRvIGNyZWF0ZSAic2VjcmV0Ig0KbWVtb3J5IGFyZWFzIi4NCg0KVGhlIHBlcmYgcHJvZmls
ZSBvZiB0aGUgdGVzdCBpbmRpY2F0ZWQgdGhhdCB0aGUgcmVncmVzc2lvbiBpcyBjYXVzZWQgYnkN
CnBhZ2VfaXNfc2VjcmV0bWVtKCkgY2FsbGVkIGZyb20gZ3VwX3B0ZV9yYW5nZSgpIChpbmxpbmVk
IGJ5IGd1cF9wZ2RfcmFuZ2UpOg0KDQogMjcuNzYgICsyLjUgIDMwLjIzICAgICAgIHBlcmYtcHJv
ZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAuZ3VwX3BnZF9yYW5nZQ0KICAwLjAwICArMy4yICAgMy4x
OSDCsSAyJSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5wYWdlX21hcHBpbmcNCiAg
MC4wMCAgKzMuNyAgIDMuNjYgwrEgMiUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAu
cGFnZV9pc19zZWNyZXRtZW0NCg0KRnVydGhlciBhbmFseXNpcyBzaG93ZWQgdGhhdCB0aGUgc2xv
dyBkb3duIGhhcHBlbnMgYmVjYXVzZSBuZWl0aGVyDQpwYWdlX2lzX3NlY3JldG1lbSgpIG5vciBw
YWdlX21hcHBpbmcoKSBhcmUgbm90IGlubGluZSBhbmQgbW9yZW92ZXIsDQptdWx0aXBsZSBwYWdl
IGZsYWdzIGNoZWNrcyBpbiBwYWdlX21hcHBpbmcoKSBpbnZvbHZlIGNhbGxpbmcNCmNvbXBvdW5k
X2hlYWQoKSBzZXZlcmFsIHRpbWVzIGZvciB0aGUgc2FtZSBwYWdlLg0KDQpNYWtlIHBhZ2VfaXNf
c2VjcmV0bWVtKCkgaW5saW5lIGFuZCByZXBsYWNlIHBhZ2VfbWFwcGluZygpIHdpdGggcGFnZSBm
bGFnDQpjaGVja3MgdGhhdCBkbyBub3QgaW1wbHkgcGFnZS10by1oZWFkIGNvbnZlcnNpb24uDQoN
ClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KLS0tDQog
aW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKyst
DQogbW0vc2VjcmV0bWVtLmMgICAgICAgICAgICB8IDEyICstLS0tLS0tLS0tLQ0KIDIgZmlsZXMg
Y2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oIGIvaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaA0K
aW5kZXggOTA3YTY3MzQwNTljLi5iODQyYjM4Y2JlYjEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xp
bnV4L3NlY3JldG1lbS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oDQpAQCAtNCw4
ICs0LDMyIEBADQogDQogI2lmZGVmIENPTkZJR19TRUNSRVRNRU0NCiANCitleHRlcm4gY29uc3Qg
c3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBzZWNyZXRtZW1fYW9wczsNCisNCitzdGF0
aWMgaW5saW5lIGJvb2wgcGFnZV9pc19zZWNyZXRtZW0oc3RydWN0IHBhZ2UgKnBhZ2UpDQorew0K
KwlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZzsNCisNCisJLyoNCisJICogVXNpbmcgcGFn
ZV9tYXBwaW5nKCkgaXMgcXVpdGUgc2xvdyBiZWNhdXNlIG9mIHRoZSBhY3R1YWwgY2FsbA0KKwkg
KiBpbnN0cnVjdGlvbiBhbmQgcmVwZWF0ZWQgY29tcG91bmRfaGVhZChwYWdlKSBpbnNpZGUgdGhl
DQorCSAqIHBhZ2VfbWFwcGluZygpIGZ1bmN0aW9uLg0KKwkgKiBXZSBrbm93IHRoYXQgc2VjcmV0
bWVtIHBhZ2VzIGFyZSBub3QgY29tcG91bmQgYW5kIExSVSBzbyB3ZSBjYW4NCisJICogc2F2ZSBh
IGNvdXBsZSBvZiBjeWNsZXMgaGVyZS4NCisJICovDQorCWlmIChQYWdlQ29tcG91bmQocGFnZSkg
fHwgIVBhZ2VMUlUocGFnZSkpDQorCQlyZXR1cm4gZmFsc2U7DQorDQorCW1hcHBpbmcgPSAoc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKikNCisJCSgodW5zaWduZWQgbG9uZylwYWdlLT5tYXBwaW5nICYg
flBBR0VfTUFQUElOR19GTEFHUyk7DQorDQorCWlmIChtYXBwaW5nICE9IHBhZ2UtPm1hcHBpbmcp
DQorCQlyZXR1cm4gZmFsc2U7DQorDQorCXJldHVybiBwYWdlLT5tYXBwaW5nLT5hX29wcyA9PSAm
c2VjcmV0bWVtX2FvcHM7DQorfQ0KKw0KIGJvb2wgdm1hX2lzX3NlY3JldG1lbShzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKnZtYSk7DQotYm9vbCBwYWdlX2lzX3NlY3JldG1lbShzdHJ1Y3QgcGFnZSAq
cGFnZSk7DQogYm9vbCBzZWNyZXRtZW1fYWN0aXZlKHZvaWQpOw0KIA0KICNlbHNlDQpkaWZmIC0t
Z2l0IGEvbW0vc2VjcmV0bWVtLmMgYi9tbS9zZWNyZXRtZW0uYw0KaW5kZXggM2IxYmEzOTkxOTY0
Li4wYmNkMTVlMWI1NDkgMTAwNjQ0DQotLS0gYS9tbS9zZWNyZXRtZW0uYw0KKysrIGIvbW0vc2Vj
cmV0bWVtLmMNCkBAIC0xNTEsMjIgKzE1MSwxMiBAQCBzdGF0aWMgdm9pZCBzZWNyZXRtZW1fZnJl
ZXBhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQogCWNsZWFyX2hpZ2hwYWdlKHBhZ2UpOw0KIH0NCiAN
Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBzZWNyZXRtZW1f
YW9wcyA9IHsNCitjb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHNlY3JldG1l
bV9hb3BzID0gew0KIAkuZnJlZXBhZ2UJPSBzZWNyZXRtZW1fZnJlZXBhZ2UsDQogCS5taWdyYXRl
cGFnZQk9IHNlY3JldG1lbV9taWdyYXRlcGFnZSwNCiAJLmlzb2xhdGVfcGFnZQk9IHNlY3JldG1l
bV9pc29sYXRlX3BhZ2UsDQogfTsNCiANCi1ib29sIHBhZ2VfaXNfc2VjcmV0bWVtKHN0cnVjdCBw
YWdlICpwYWdlKQ0KLXsNCi0Jc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcgPSBwYWdlX21h
cHBpbmcocGFnZSk7DQotDQotCWlmICghbWFwcGluZykNCi0JCXJldHVybiBmYWxzZTsNCi0NCi0J
cmV0dXJuIG1hcHBpbmctPmFfb3BzID09ICZzZWNyZXRtZW1fYW9wczsNCi19DQotDQogc3RhdGlj
IHN0cnVjdCB2ZnNtb3VudCAqc2VjcmV0bWVtX21udDsNCiANCiBzdGF0aWMgc3RydWN0IGZpbGUg
KnNlY3JldG1lbV9maWxlX2NyZWF0ZSh1bnNpZ25lZCBsb25nIGZsYWdzKQ0KLS0gDQoyLjI4LjAN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
