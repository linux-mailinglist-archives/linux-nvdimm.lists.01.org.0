Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367C363DDD
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 10:42:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 236E6100EBB78;
	Mon, 19 Apr 2021 01:42:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 22BDF100EBB6A
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 01:42:37 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31DCF60FF1;
	Mon, 19 Apr 2021 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1618821755;
	bh=ZF11+tf8Vhkw2CEEFwa77xqf5VWgUkXxrjvgn6XQs/g=;
	h=From:To:Cc:Subject:Date:From;
	b=nahTyurCdGGs/pKCEP8Ak/lpVtsi3V/pYxzKOzhHQVRrgd+HwSBHMp1c9VUvrUitZ
	 lJO9E6YcRd6HfnllMc4TARUDu7xLHMaT5wCrC0xq5KCkq7QPScpBbwGhtKL2cUnlca
	 S/XmN2p6Y5UiygqA4Iw/VW3Ovb/Tm7XMV2dSuU0Vx5JbaHgjAcQZGedyYpI5bGdNUN
	 Swxd/sv5Pgcqe5q+W3CHtA8D5LIhwcS+NCKcymUNnFpMQPAS39WzvUsgIx4yz1H69k
	 n9/rwnGjwqls7iqtmMKQ0KOPa18PvcYsCiO1B+OHgixQZ6x49EO1+/4Ba+tjGA33KC
	 ROLb1q5BZJDGA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] secretmem: optimize page_is_secretmem()
Date: Mon, 19 Apr 2021 11:42:18 +0300
Message-Id: <20210419084218.7466-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Message-ID-Hash: QFLOTFBZGPN6JXQZBXMV2TFRAZ3KJ4UM
X-Message-ID-Hash: QFLOTFBZGPN6JXQZBXMV2TFRAZ3KJ4UM
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel B
 utt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QFLOTFBZGPN6JXQZBXMV2TFRAZ3KJ4UM/>
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
U2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KLS0tDQoN
CkBBbmRyZXcsDQpUaGUgcGF0Y2ggaXMgdnMgdjUuMTItcmM3LW1tb3RzLTIwMjEtMDQtMTUtMTYt
MjgsIEknZCBhcHByZWNpYXRlIGlmIGl0IHdvdWxkDQpiZSBhZGRlZCBhcyBhIGZpeHVwIHRvIHRo
ZSBtZW1mZF9zZWNyZXQgc2VyaWVzLg0KDQogaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaCB8IDI2
ICsrKysrKysrKysrKysrKysrKysrKysrKystDQogbW0vc2VjcmV0bWVtLmMgICAgICAgICAgICB8
IDEyICstLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTIg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oIGIv
aW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaA0KaW5kZXggOTA3YTY3MzQwNTljLi5iODQyYjM4Y2Jl
YjEgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oDQorKysgYi9pbmNsdWRl
L2xpbnV4L3NlY3JldG1lbS5oDQpAQCAtNCw4ICs0LDMyIEBADQogDQogI2lmZGVmIENPTkZJR19T
RUNSRVRNRU0NCiANCitleHRlcm4gY29uc3Qgc3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9u
cyBzZWNyZXRtZW1fYW9wczsNCisNCitzdGF0aWMgaW5saW5lIGJvb2wgcGFnZV9pc19zZWNyZXRt
ZW0oc3RydWN0IHBhZ2UgKnBhZ2UpDQorew0KKwlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGlu
ZzsNCisNCisJLyoNCisJICogVXNpbmcgcGFnZV9tYXBwaW5nKCkgaXMgcXVpdGUgc2xvdyBiZWNh
dXNlIG9mIHRoZSBhY3R1YWwgY2FsbA0KKwkgKiBpbnN0cnVjdGlvbiBhbmQgcmVwZWF0ZWQgY29t
cG91bmRfaGVhZChwYWdlKSBpbnNpZGUgdGhlDQorCSAqIHBhZ2VfbWFwcGluZygpIGZ1bmN0aW9u
Lg0KKwkgKiBXZSBrbm93IHRoYXQgc2VjcmV0bWVtIHBhZ2VzIGFyZSBub3QgY29tcG91bmQgYW5k
IExSVSBzbyB3ZSBjYW4NCisJICogc2F2ZSBhIGNvdXBsZSBvZiBjeWNsZXMgaGVyZS4NCisJICov
DQorCWlmIChQYWdlQ29tcG91bmQocGFnZSkgfHwgIVBhZ2VMUlUocGFnZSkpDQorCQlyZXR1cm4g
ZmFsc2U7DQorDQorCW1hcHBpbmcgPSAoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKikNCisJCSgodW5z
aWduZWQgbG9uZylwYWdlLT5tYXBwaW5nICYgflBBR0VfTUFQUElOR19GTEFHUyk7DQorDQorCWlm
IChtYXBwaW5nICE9IHBhZ2UtPm1hcHBpbmcpDQorCQlyZXR1cm4gZmFsc2U7DQorDQorCXJldHVy
biBwYWdlLT5tYXBwaW5nLT5hX29wcyA9PSAmc2VjcmV0bWVtX2FvcHM7DQorfQ0KKw0KIGJvb2wg
dm1hX2lzX3NlY3JldG1lbShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7DQotYm9vbCBwYWdl
X2lzX3NlY3JldG1lbShzdHJ1Y3QgcGFnZSAqcGFnZSk7DQogYm9vbCBzZWNyZXRtZW1fYWN0aXZl
KHZvaWQpOw0KIA0KICNlbHNlDQpkaWZmIC0tZ2l0IGEvbW0vc2VjcmV0bWVtLmMgYi9tbS9zZWNy
ZXRtZW0uYw0KaW5kZXggM2IxYmEzOTkxOTY0Li4wYmNkMTVlMWI1NDkgMTAwNjQ0DQotLS0gYS9t
bS9zZWNyZXRtZW0uYw0KKysrIGIvbW0vc2VjcmV0bWVtLmMNCkBAIC0xNTEsMjIgKzE1MSwxMiBA
QCBzdGF0aWMgdm9pZCBzZWNyZXRtZW1fZnJlZXBhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQogCWNs
ZWFyX2hpZ2hwYWdlKHBhZ2UpOw0KIH0NCiANCi1zdGF0aWMgY29uc3Qgc3RydWN0IGFkZHJlc3Nf
c3BhY2Vfb3BlcmF0aW9ucyBzZWNyZXRtZW1fYW9wcyA9IHsNCitjb25zdCBzdHJ1Y3QgYWRkcmVz
c19zcGFjZV9vcGVyYXRpb25zIHNlY3JldG1lbV9hb3BzID0gew0KIAkuZnJlZXBhZ2UJPSBzZWNy
ZXRtZW1fZnJlZXBhZ2UsDQogCS5taWdyYXRlcGFnZQk9IHNlY3JldG1lbV9taWdyYXRlcGFnZSwN
CiAJLmlzb2xhdGVfcGFnZQk9IHNlY3JldG1lbV9pc29sYXRlX3BhZ2UsDQogfTsNCiANCi1ib29s
IHBhZ2VfaXNfc2VjcmV0bWVtKHN0cnVjdCBwYWdlICpwYWdlKQ0KLXsNCi0Jc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcgPSBwYWdlX21hcHBpbmcocGFnZSk7DQotDQotCWlmICghbWFwcGlu
ZykNCi0JCXJldHVybiBmYWxzZTsNCi0NCi0JcmV0dXJuIG1hcHBpbmctPmFfb3BzID09ICZzZWNy
ZXRtZW1fYW9wczsNCi19DQotDQogc3RhdGljIHN0cnVjdCB2ZnNtb3VudCAqc2VjcmV0bWVtX21u
dDsNCiANCiBzdGF0aWMgc3RydWN0IGZpbGUgKnNlY3JldG1lbV9maWxlX2NyZWF0ZSh1bnNpZ25l
ZCBsb25nIGZsYWdzKQ0KLS0gDQoyLjI4LjANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
