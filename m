Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8522B424
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 19:08:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D939C125181A5;
	Thu, 23 Jul 2020 10:08:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 790B212505D89
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 10:08:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l6so2825487plt.7
        for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NPbssqK1INtrFyjAUzj5mlbSJgxK4WzDaPmXZHhkVOg=;
        b=yoXd9uVkO2vV1qapKWvg6gqU+YlOechgMeu61k1dp7CN9clp8UmaHRbquyhgRG0EEc
         qzNe84TrLIXIyjqC0IiE0n1EHX+P8HvoY7yvHrCHdph8GNfNnaBIpslpqlns5gX8TQ4q
         Bjc8eIcn2XxbBGMyr4IOZe4gzlsbUnxZEddFJMD7FKjlftnULb8az0udybrX2ZdDEO6x
         +Zy+/yT5PdnRQvQeYA0xF4eJxdQH8BXXKKGfX9TFsapCl/a4p9//S4304AlD7ypcAdCx
         lgtOkhY7tTnU+9KXye1d1QzYZAXqKP44YDuwrRT/s98xYKGWvdcqCEQ8yQLWxSOQlrvX
         Yn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NPbssqK1INtrFyjAUzj5mlbSJgxK4WzDaPmXZHhkVOg=;
        b=G+ErXeS/EWxfxt/sxmhlXs4/FcS3TRKdqm8Z2OXYD9o2TJCgbWB5rnGjf2KyQ8uU66
         laNFdxHqKzK63RlleEAISTIwIGrqyi5d9uNGDlNlEijMZGXxkH91eKF1l4PPJg80zRSZ
         siOODOtI+bLfWWeyWV90r6w91wkfQFfsP5ElZLV45aPLF1lAPozdLemK8wPBbIULQaKn
         WgJp5sWaXNHY/DsojSVNNATi61l+UWg0l57vhN7kfnnH/cD8vCOrnNwyf+Rx7VI+PzCr
         gQ/TmH/Yf/vJIl289rbakE9O+UNkV+d4pStW1M97+8WgzEFKVKYfKR4Bhr5z2K0wga/1
         RZ6w==
X-Gm-Message-State: AOAM530FhHWw57MFS+aYKgPxIqHUAdLjvICHJGqrJTJCK+kNhz3APOqZ
	BDmIaxthkGgx2jKtUM2LZEBynw==
X-Google-Smtp-Source: ABdhPJzhEVeWE+MsYhg97fGrJZMWD4MyQ/tPFCjeaW/T/ed2wa91gkVSb8XcX/EmBjVpwheP/E/Q+w==
X-Received: by 2002:a17:90a:ff0c:: with SMTP id ce12mr1353809pjb.100.1595524125805;
        Thu, 23 Jul 2020 10:08:45 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ecdf:69cc:bc40:aa6d? ([2601:646:c200:1ef2:ecdf:69cc:bc40:aa6d])
        by smtp.gmail.com with ESMTPSA id v197sm3695465pfc.35.2020.07.23.10.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 10:08:45 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date: Thu, 23 Jul 2020 10:08:42 -0700
Message-Id: <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
In-Reply-To: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17F80)
Message-ID-Hash: 2FYB2TOEII7SSFWZ2WY2EYAQMZ6DUNZ2
X-Message-ID-Hash: 2FYB2TOEII7SSFWZ2WY2EYAQMZ6DUNZ2
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2FYB2TOEII7SSFWZ2WY2EYAQMZ6DUNZ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIEp1bCAyMywgMjAyMCwgYXQgOTo1MiBBTSwgRmVuZ2h1YSBZdSA8ZmVuZ2h1YS55dUBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/SGksIERhdmUsDQo+IA0KPj4gT24gVGh1LCBKdWwg
MjMsIDIwMjAgYXQgMDk6MjM6MTNBTSAtMDcwMCwgRGF2ZSBIYW5zZW4gd3JvdGU6DQo+Pj4gT24g
Ny8yMy8yMCA5OjE4IEFNLCBGZW5naHVhIFl1IHdyb3RlOg0KPj4+IFRoZSBQS1JTIE1TUiBoYXMg
YmVlbiBwcmVzZXJ2ZWQgaW4gdGhyZWFkX2luZm8gZHVyaW5nIGtlcm5lbCBlbnRyeS4gV2UNCj4+
PiBkb24ndCBuZWVkIHRvIHByZXNlcnZlIGl0IGluIGFub3RoZXIgcGxhY2UgKGkuZS4gaWR0ZW50
cnlfc3RhdGUpLg0KPj4gDQo+PiBJJ20gbWlzc2luZyBob3cgdGhlIFBLUlMgTVNSIGdldHMgcHJl
c2VydmVkIGluIHRocmVhZF9pbmZvLiAgQ291bGQgeW91DQo+PiBleHBsYWluIHRoZSBtZWNoYW5p
c20gYnkgd2hpY2ggdGhpcyBoYXBwZW5zIGFuZCBwb2ludCB0byB0aGUgY29kZQ0KPj4gaW1wbGVt
ZW50aW5nIGl0LCBwbGVhc2U/DQo+IA0KPiBbU29ycnksIG15IG1pc3Rha2U6IEkgbWVhbiAidGhy
ZWFkX3N0cnVjdCIgaW5zdGVhZCBvZiAidGhyZWFkX2luZm8iLg0KPiBIb3BlZnVsbHkgdGhlIHR5
cG8gZG9lc24ndCBjaGFuZ2UgdGhlIGVzc2VudGlhbCBwYXJ0IGluIG15IGxhc3QgZW1haWwuXQ0K
PiANCj4gVGhlICJzYXZlZF9wa3JzIiBpcyBkZWZpbmVkIGluIHRocmVhZF9zdHJ1Y3QgYW5kIGNv
bnRleHQgc3dpdGNoZWQgaW4NCj4gcGF0Y2ggMDQvMTc6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyMDA3MTcwNzIwNTYuNzMxMzQtNS1pcmEud2VpbnlAaW50ZWwuY29tLw0KPiAN
Cj4gQmVjYXVzZSB0aGVyZSBpcyBubyBYU0FWRSBzdXBwb3J0IHRoZSBQS1JTIE1TUiwgd2UgcHJl
c2VydmUgaXQgaW4NCj4gInNhdmVkX3BrcnMiIGluIHRocmVhZF9zdHJ1Y3QuIEl0J3MgaW5pdGlh
bGl6ZWQgYXMgMCAoaW5pdCBzdGF0ZSwgbm8NCj4gcHJvdGVjdGlvbiBrZXkpIGluIGZvcmsoKSBv
ciBleGVjKCkuIEl0J3MgdXBkYXRlZCB0byBhIHJpZ2h0IHByb3RlY3Rpb24NCj4gdmFsdWUgd2hl
biBhIGRyaXZlciBjYWxscyB0aGUgdXBkYXRpbmcgQVBJLiBUaGUgUEtSUyBNU1IgaXMgY29udGV4
dA0KPiBzd2l0Y2hlZCBieSAic2F2ZWRfcGtycyIgd2hlbiBzd2l0Y2hpbmcgdG8gYSB0YXNrICh1
bmxlc3Mgb3B0aW1pemVkIGlmIHRoZQ0KPiBjYWNoZWQgTVNSIGlzIHRoZSBzYW1lIGFzIHRoZSBz
YXZlZCBvbmUpLg0KPiANCj4gDQoNClN1cHBvc2Ugc29tZSBrZXJuZWwgY29kZSAoYSBzeXNjYWxs
IG9yDQprZXJuZWwgdGhyZWFkKSBjaGFuZ2VzIFBLUlMgdGhlbiB0YWtlcyBhIHBhZ2UgZmF1bHQu
IFRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgbmVlZHMgYSBmcmVzaCBQS1JTLiBUaGVuIHRoZSBwYWdl
IGZhdWx0IGhhbmRsZXIgKHNheSBhIFZNQeKAmXMgLmZhdWx0IGhhbmRsZXIpIGNoYW5nZXMgUEtS
Uy4gIFRoZSB3ZSBnZXQgYW4gaW50ZXJydXB0LiBUaGUgaW50ZXJydXB0ICphbHNvKiBuZWVkcyBh
IGZyZXNoIFBLUlMgYW5kIHRoZSBwYWdlIGZhdWx0IHZhbHVlIG5lZWRzIHRvIGJlIHNhdmVkIHNv
bWV3aGVyZS4NCg0KU28gd2UgaGF2ZSBtb3JlIHRoYW4gb25lIHNhdmVkIHZhbHVlIHBlciB0aHJl
YWQsIGFuZCB0aHJlYWRfc3RydWN0IGlzbuKAmXQgZ29pbmcgdG8gc29sdmUgdGhpcyBwcm9ibGVt
Lg0KDQpCdXQgaWR0ZW50cnlfc3RhdGUgaXMgYWxzbyBub3QgZ3JlYXQgZm9yIGEgY291cGxlIHJl
YXNvbnMuICBOb3QgYWxsIGVudHJpZXMgaGF2ZSBpZHRlbnRyeV9zdGF0ZSwgYW5kIHRoZSB1bndp
bmRlciBjYW7igJl0IGZpbmQgaXQgZm9yIGRlYnVnZ2luZy4gRm9yIHRoYXQgbWF0dGVyLCB0aGUg
cGFnZSBmYXVsdCBsb2dpYyBwcm9iYWJseSB3YW50cyB0byBrbm93IHRoZSBwcmV2aW91cyBQS1JT
LCBzbyBpdCBzaG91bGQgZWl0aGVyIGJlIHN0YXNoZWQgc29tZXdoZXJlIGZpbmRhYmxlIG9yIGl0
IHNob3VsZCBiZSBleHBsaWNpdGx5IHBhc3NlZCBhcm91bmQuDQoNCk15IHN1Z2dlc3Rpb24gaXMg
dG8gZW5sYXJnZSBwdF9yZWdzLiAgVGhlIHNhdmUgYW5kIHJlc3RvcmUgbG9naWMgY2FuIHByb2Jh
Ymx5IGJlIGluIEMsIGJ1dCBwdF9yZWdzIGlzIHRoZSBsb2dpY2FsIHBsYWNlIHRvIHB1dCBhIHJl
Z2lzdGVyIHRoYXQgaXMgc2F2ZWQgYW5kIHJlc3RvcmVkIGFjcm9zcyBhbGwgZW50cmllcy4NCg0K
V2hvZXZlciBkb2VzIHRoaXMgd29yayB3aWxsIGhhdmUgdGhlIGRlbGlnaHRmdWwgam9iIG9mIGZp
Z3VyaW5nIG91dCB3aGV0aGVyIEJQRiB0aGlua3MgdGhhdCB0aGUgbGF5b3V0IG9mIHB0X3JlZ3Mg
aXMgQUJJIGFuZCwgaWYgc28sIGZpeGluZyB0aGUgcmVzdWx0aW5nIG1lc3MuDQoNClRoZSBmYWN0
IHRoZSBuZXcgZmllbGRzIHdpbGwgZ28gYXQgdGhlIGJlZ2lubmluZyBvZiBwdF9yZWdzIHdpbGwg
bWFrZSB0aGlzIGFuIGVudGVydGFpbmluZyBwcm9zcGVjdC4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
