Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C04B22B4DA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 19:30:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F08812509D82;
	Thu, 23 Jul 2020 10:30:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dave.hansen@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6E26B12509D81
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 10:30:33 -0700 (PDT)
IronPort-SDR: lwJLQmL8e1AagDDnegBTx/l2HPlPIm00SvgMCgPYjV+yFfig06ig6/rHLWn6A757a9y/N7V4Dw
 F2R+XlFHPUJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="149769739"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="149769739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:30:32 -0700
IronPort-SDR: gqKvpMmiWky5X0ghBbiaK3jF97xdeU9ME6ECe9K6z/VLCqvJx4wgrvxflJlCkTD031UPAnoTlZ
 UB5sF/mFQu8Q==
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800";
   d="scan'208";a="393073616"
Received: from bhkleins-mobl.amr.corp.intel.com (HELO [10.252.140.192]) ([10.252.140.192])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:30:31 -0700
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
To: Andy Lutomirski <luto@amacapital.net>, Fenghua Yu <fenghua.yu@intel.com>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
 <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <71f0e3d8-6dfa-742d-eaa7-330b59611e2f@intel.com>
Date: Thu, 23 Jul 2020 10:30:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
Content-Language: en-US
Message-ID-Hash: ZFAIZ7P7ZO76ZDS7YWWEVFBJEAR5IKZW
X-Message-ID-Hash: ZFAIZ7P7ZO76ZDS7YWWEVFBJEAR5IKZW
X-MailFrom: dave.hansen@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZFAIZ7P7ZO76ZDS7YWWEVFBJEAR5IKZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gNy8yMy8yMCAxMDowOCBBTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiBTdXBwb3NlIHNv
bWUga2VybmVsIGNvZGUgKGEgc3lzY2FsbCBvciBrZXJuZWwgdGhyZWFkKSBjaGFuZ2VzIFBLUlMN
Cj4gdGhlbiB0YWtlcyBhIHBhZ2UgZmF1bHQuIFRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgbmVlZHMg
YSBmcmVzaCBQS1JTLg0KPiBUaGVuIHRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgKHNheSBhIFZNQeKA
mXMgLmZhdWx0IGhhbmRsZXIpIGNoYW5nZXMNCj4gUEtSUy4gIFRoZSB3ZSBnZXQgYW4gaW50ZXJy
dXB0LiBUaGUgaW50ZXJydXB0ICphbHNvKiBuZWVkcyBhIGZyZXNoDQo+IFBLUlMgYW5kIHRoZSBw
YWdlIGZhdWx0IHZhbHVlIG5lZWRzIHRvIGJlIHNhdmVkIHNvbWV3aGVyZS4NCj4gDQo+IFNvIHdl
IGhhdmUgbW9yZSB0aGFuIG9uZSBzYXZlZCB2YWx1ZSBwZXIgdGhyZWFkLCBhbmQgdGhyZWFkX3N0
cnVjdA0KPiBpc27igJl0IGdvaW5nIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCg0KVGFraW5nIGEg
c3RlcCBiYWNrLi4uICBUaGlzIGlzIGFsbCB0cnVlIG9ubHkgaWYgd2UgZGVjaWRlIHRoYXQgd2Ug
d2FudA0KcHJvdGVjdGlvbiBrZXlzIHRvIHByb3ZpZGUgcHJvdGVjdGlvbiBkdXJpbmcgZXhjZXB0
aW9ucyBhbmQgaW50ZXJydXB0cy4NCiBSaWdodCBub3csIHRoZSBjb2RlIHN1cHBvcnRzIG5lc3Rp
bmc6DQoNCglrbWFwKGZvbyk7DQoJCWttYXAoYmFyKTsNCgkJa3VubWFwKGJhcik7DQoJa3VubWFw
KGZvbyk7DQoNCndpdGggYSByZWZlcmVuY2UgY291bnQuICBTbywgdGhlIG5lc3RlZCBrbWFwKCkg
d2lsbCBzZWUgdGhlIGNvdW50DQplbGV2YXRlZCBhbmQgZG8gbm90aGluZy4NCg0KSSdtIGdlbmVy
YWxseSBPSyB3aXRoIHRoaXMgZ2V0dGluZyBtZXJnZWQgd2l0aG91dCBleHRlbmRpbmcgUEtTDQpw
cm90ZWN0aW9uIHRvIGludGVycnVwdHMgYW5kIGV4Y2VwdGlvbnMuICBJcmEgYW5kIEZlbmdodWEg
c2hvdWxkDQpjZXJ0YWlubHkgZ2l2ZSBpdCBhIGdvLCBidXQgSSdkIGxpa2UgdG8gc2VlIGl0IGFz
IGFuIGFkZC1vbiBmZWF0dXJlIGFuZA0Kd2UgY2FuIGp1ZGdlIHRoZSBiZW5lZml0cyB2ZXJzdXMg
Y29tcGxleGl0eSBzZXBhcmF0ZWx5Lg0KDQpJcmEgd2FzIGxvb2tpbmcgYXQgYWRkaW5nIGl0IGJl
Y2F1c2UgaXQgX2xvb2tlZF8gc2ltcGxlLiAgQW5keSBoYXMgbWUNCnJlYWxseSBzY2FyZWQgYWJv
dXQgaXQgbm93LiA6KQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
