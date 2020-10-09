Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D177C28944C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Oct 2020 21:53:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5428159C2224;
	Fri,  9 Oct 2020 12:53:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB4B3159C2226
	for <linux-nvdimm@lists.01.org>; Fri,  9 Oct 2020 12:53:54 -0700 (PDT)
IronPort-SDR: OdYHfBEOIIL4t7RnyiyNIJtXkywvNXY0fFUL6eqejKTI8fcTNUgPX35Y3BvdV8LugZ2qYM2nVI
 3mI2EKFO32JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="250226348"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="250226348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:54 -0700
IronPort-SDR: bZn0Zma13YkX7FJFkNsCYMjMNff2FSiB/MgoUwYT50qMOfu0yRYfZtOtUYx1uwuwPtN+tdFX+r
 hwly4wq6Ikyg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400";
   d="scan'208";a="519847271"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 12:53:53 -0700
From: ira.weiny@intel.com
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC PKS/PMEM 53/58] lib: Utilize new kmap_thread()
Date: Fri,  9 Oct 2020 12:50:28 -0700
Message-Id: <20201009195033.3208459-54-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201009195033.3208459-1-ira.weiny@intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: B2V7KUJUIKH3YEEZ2VMRYNOUAYZTGP5V
X-Message-ID-Hash: B2V7KUJUIKH3YEEZ2VMRYNOUAYZTGP5V
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Alexander Viro <viro@zeniv.linux.org.uk>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org, linux-efi@vger.kernel.org, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-aio@kvack.o
 rg, io-uring@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-um@lists.infradead.org, linux-ntfs-dev@lists.sourceforge.net, reiserfs-devel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-nilfs@vger.kernel.org, cluster-devel@redhat.com, ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-afs@lists.infradead.org, linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, xen-devel@lists.xenproject.org, linux-cachefs@redhat.com, samba-technical@lists.samba.org, intel-wired-lan@lists.osuosl.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B2V7KUJUIKH3YEEZ2VMRYNOUAYZTGP5V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RnJvbTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KDQpUaGVzZSBrbWFwKCkgY2Fs
bHMgYXJlIGxvY2FsaXplZCB0byBhIHNpbmdsZSB0aHJlYWQuICBUbyBhdm9pZCB0aGUgb3Zlcg0K
aGVhZCBvZiBnbG9iYWwgUEtSUyB1cGRhdGVzIHVzZSB0aGUgbmV3IGttYXBfdGhyZWFkKCkgY2Fs
bC4NCg0KQ2M6IEFsZXhhbmRlciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4NCkNjOiAi
SsOpcsO0bWUgR2xpc3NlIiA8amdsaXNzZUByZWRoYXQuY29tPg0KQ2M6IE1hcnRpbiBLYUZhaSBM
YXUgPGthZmFpQGZiLmNvbT4NCkNjOiBTb25nIExpdSA8c29uZ2xpdWJyYXZpbmdAZmIuY29tPg0K
Q2M6IFlvbmdob25nIFNvbmcgPHloc0BmYi5jb20+DQpDYzogQW5kcmlpIE5ha3J5aWtvIDxhbmRy
aWluQGZiLmNvbT4NCkNjOiBKb2huIEZhc3RhYmVuZCA8am9obi5mYXN0YWJlbmRAZ21haWwuY29t
Pg0KQ2M6IEtQIFNpbmdoIDxrcHNpbmdoQGNocm9taXVtLm9yZz4NClNpZ25lZC1vZmYtYnk6IEly
YSBXZWlueSA8aXJhLndlaW55QGludGVsLmNvbT4NCi0tLQ0KIGxpYi9pb3ZfaXRlci5jIHwgMTIg
KysrKysrLS0tLS0tDQogbGliL3Rlc3RfYnBmLmMgfCAgNCArKy0tDQogbGliL3Rlc3RfaG1tLmMg
fCAgOCArKysrLS0tLQ0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9saWIvaW92X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5j
DQppbmRleCA1ZTQwNzg2YzhmMTIuLjFkNDdmOTU3Y2Y5NSAxMDA2NDQNCi0tLSBhL2xpYi9pb3Zf
aXRlci5jDQorKysgYi9saWIvaW92X2l0ZXIuYw0KQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMg
c2l6ZV90IGNvcHlfcGFnZV90b19pdGVyX2lvdmVjKHN0cnVjdCBwYWdlICpwYWdlLCBzaXplX3Qg
b2Zmc2V0LCBzaXplX3QgYg0KIAl9DQogCS8qIFRvbyBiYWQgLSByZXZlcnQgdG8gbm9uLWF0b21p
YyBrbWFwICovDQogDQotCWthZGRyID0ga21hcChwYWdlKTsNCisJa2FkZHIgPSBrbWFwX3RocmVh
ZChwYWdlKTsNCiAJZnJvbSA9IGthZGRyICsgb2Zmc2V0Ow0KIAlsZWZ0ID0gY29weW91dChidWYs
IGZyb20sIGNvcHkpOw0KIAljb3B5IC09IGxlZnQ7DQpAQCAtMjI1LDcgKzIyNSw3IEBAIHN0YXRp
YyBzaXplX3QgY29weV9wYWdlX3RvX2l0ZXJfaW92ZWMoc3RydWN0IHBhZ2UgKnBhZ2UsIHNpemVf
dCBvZmZzZXQsIHNpemVfdCBiDQogCQlmcm9tICs9IGNvcHk7DQogCQlieXRlcyAtPSBjb3B5Ow0K
IAl9DQotCWt1bm1hcChwYWdlKTsNCisJa3VubWFwX3RocmVhZChwYWdlKTsNCiANCiBkb25lOg0K
IAlpZiAoc2tpcCA9PSBpb3YtPmlvdl9sZW4pIHsNCkBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGlj
IHNpemVfdCBjb3B5X3BhZ2VfZnJvbV9pdGVyX2lvdmVjKHN0cnVjdCBwYWdlICpwYWdlLCBzaXpl
X3Qgb2Zmc2V0LCBzaXplX3QNCiAJfQ0KIAkvKiBUb28gYmFkIC0gcmV2ZXJ0IHRvIG5vbi1hdG9t
aWMga21hcCAqLw0KIA0KLQlrYWRkciA9IGttYXAocGFnZSk7DQorCWthZGRyID0ga21hcF90aHJl
YWQocGFnZSk7DQogCXRvID0ga2FkZHIgKyBvZmZzZXQ7DQogCWxlZnQgPSBjb3B5aW4odG8sIGJ1
ZiwgY29weSk7DQogCWNvcHkgLT0gbGVmdDsNCkBAIC0zMDksNyArMzA5LDcgQEAgc3RhdGljIHNp
emVfdCBjb3B5X3BhZ2VfZnJvbV9pdGVyX2lvdmVjKHN0cnVjdCBwYWdlICpwYWdlLCBzaXplX3Qg
b2Zmc2V0LCBzaXplX3QNCiAJCXRvICs9IGNvcHk7DQogCQlieXRlcyAtPSBjb3B5Ow0KIAl9DQot
CWt1bm1hcChwYWdlKTsNCisJa3VubWFwX3RocmVhZChwYWdlKTsNCiANCiBkb25lOg0KIAlpZiAo
c2tpcCA9PSBpb3YtPmlvdl9sZW4pIHsNCkBAIC0xNzQyLDEwICsxNzQyLDEwIEBAIGludCBpb3Zf
aXRlcl9mb3JfZWFjaF9yYW5nZShzdHJ1Y3QgaW92X2l0ZXIgKmksIHNpemVfdCBieXRlcywNCiAJ
CXJldHVybiAwOw0KIA0KIAlpdGVyYXRlX2FsbF9raW5kcyhpLCBieXRlcywgdiwgLUVJTlZBTCwg
KHsNCi0JCXcuaW92X2Jhc2UgPSBrbWFwKHYuYnZfcGFnZSkgKyB2LmJ2X29mZnNldDsNCisJCXcu
aW92X2Jhc2UgPSBrbWFwX3RocmVhZCh2LmJ2X3BhZ2UpICsgdi5idl9vZmZzZXQ7DQogCQl3Lmlv
dl9sZW4gPSB2LmJ2X2xlbjsNCiAJCWVyciA9IGYoJncsIGNvbnRleHQpOw0KLQkJa3VubWFwKHYu
YnZfcGFnZSk7DQorCQlrdW5tYXBfdGhyZWFkKHYuYnZfcGFnZSk7DQogCQllcnI7fSksICh7DQog
CQl3ID0gdjsNCiAJCWVyciA9IGYoJncsIGNvbnRleHQpO30pDQpkaWZmIC0tZ2l0IGEvbGliL3Rl
c3RfYnBmLmMgYi9saWIvdGVzdF9icGYuYw0KaW5kZXggY2E3ZDYzNWJjY2Q5Li40NDFmODIyZjU2
YmEgMTAwNjQ0DQotLS0gYS9saWIvdGVzdF9icGYuYw0KKysrIGIvbGliL3Rlc3RfYnBmLmMNCkBA
IC02NTA2LDExICs2NTA2LDExIEBAIHN0YXRpYyB2b2lkICpnZW5lcmF0ZV90ZXN0X2RhdGEoc3Ry
dWN0IGJwZl90ZXN0ICp0ZXN0LCBpbnQgc3ViKQ0KIAkJaWYgKCFwYWdlKQ0KIAkJCWdvdG8gZXJy
X2tmcmVlX3NrYjsNCiANCi0JCXB0ciA9IGttYXAocGFnZSk7DQorCQlwdHIgPSBrbWFwX3RocmVh
ZChwYWdlKTsNCiAJCWlmICghcHRyKQ0KIAkJCWdvdG8gZXJyX2ZyZWVfcGFnZTsNCiAJCW1lbWNw
eShwdHIsIHRlc3QtPmZyYWdfZGF0YSwgTUFYX0RBVEEpOw0KLQkJa3VubWFwKHBhZ2UpOw0KKwkJ
a3VubWFwX3RocmVhZChwYWdlKTsNCiAJCXNrYl9hZGRfcnhfZnJhZyhza2IsIDAsIHBhZ2UsIDAs
IE1BWF9EQVRBLCBNQVhfREFUQSk7DQogCX0NCiANCmRpZmYgLS1naXQgYS9saWIvdGVzdF9obW0u
YyBiL2xpYi90ZXN0X2htbS5jDQppbmRleCBlN2RjM2RlMzU1YjcuLmU0MGQyNmY5N2Y0NSAxMDA2
NDQNCi0tLSBhL2xpYi90ZXN0X2htbS5jDQorKysgYi9saWIvdGVzdF9obW0uYw0KQEAgLTMyOSw5
ICszMjksOSBAQCBzdGF0aWMgaW50IGRtaXJyb3JfZG9fcmVhZChzdHJ1Y3QgZG1pcnJvciAqZG1p
cnJvciwgdW5zaWduZWQgbG9uZyBzdGFydCwNCiAJCWlmICghcGFnZSkNCiAJCQlyZXR1cm4gLUVO
T0VOVDsNCiANCi0JCXRtcCA9IGttYXAocGFnZSk7DQorCQl0bXAgPSBrbWFwX3RocmVhZChwYWdl
KTsNCiAJCW1lbWNweShwdHIsIHRtcCwgUEFHRV9TSVpFKTsNCi0JCWt1bm1hcChwYWdlKTsNCisJ
CWt1bm1hcF90aHJlYWQocGFnZSk7DQogDQogCQlwdHIgKz0gUEFHRV9TSVpFOw0KIAkJYm91bmNl
LT5jcGFnZXMrKzsNCkBAIC0zOTgsOSArMzk4LDkgQEAgc3RhdGljIGludCBkbWlycm9yX2RvX3dy
aXRlKHN0cnVjdCBkbWlycm9yICpkbWlycm9yLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KIAkJaWYg
KCFwYWdlIHx8IHhhX3BvaW50ZXJfdGFnKGVudHJ5KSAhPSBEUFRfWEFfVEFHX1dSSVRFKQ0KIAkJ
CXJldHVybiAtRU5PRU5UOw0KIA0KLQkJdG1wID0ga21hcChwYWdlKTsNCisJCXRtcCA9IGttYXBf
dGhyZWFkKHBhZ2UpOw0KIAkJbWVtY3B5KHRtcCwgcHRyLCBQQUdFX1NJWkUpOw0KLQkJa3VubWFw
KHBhZ2UpOw0KKwkJa3VubWFwX3RocmVhZChwYWdlKTsNCiANCiAJCXB0ciArPSBQQUdFX1NJWkU7
DQogCQlib3VuY2UtPmNwYWdlcysrOw0KLS0gDQoyLjI4LjAucmMwLjEyLmdiNmE2NThiZDAwYzkN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
