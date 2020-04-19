Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFB81AF8FA
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 11:32:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B00110FC62F5;
	Sun, 19 Apr 2020 02:32:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=sergei.shtylyov@cogentembedded.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9361410FC62C8
	for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 02:32:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m8so6639717lji.1
        for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 02:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/v/9MZ85W5Ot6ZouiFIXv368NZt8k8Og0OLJDhh34+s=;
        b=NH0bulwrsnvt31tchVdyynbpbLgVBI1HP3Wa6GOh5EZ3Avqvjt8Ws1W0S4skKIE0JE
         uuFvwHnFs3oUQXVFI6Uw/i025gYebahgui03U0O2zWDkm//77OlUL2W1AKMBSb9Ajkej
         pH7FGvf7PIw3hRxqcpxFEFxOgYR/zkwsdko5P7TmbImGk2kTGiNw6chaFyxITHjQVqFY
         uRAVMZmeGktYjCkJxVm65ElzX8WYSVJ2k7Gs01avu1wVrvwPeK6V94oh93DTqReUmhv8
         6bEZuutMc2hlHCS5Rb8vzRuhQ8/sT8T6SFBRcGie5PJZH40vg8BxIcQxKKnbEzWKi12i
         ZLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/v/9MZ85W5Ot6ZouiFIXv368NZt8k8Og0OLJDhh34+s=;
        b=rsg+T9SVFu+VRJJpNY9smp/+0Cmit1rmLcKsLBM1KMZPtNPxGckvABoWRmSL/ld0JX
         b4Fr0YWkGCBmDsbDxs/IgA4/7k54ecrUfu9ZBpGmlk4W2T2Yqw6Gbnr60OzeZkbbxuYB
         bAmsrOsZcYJuyUZN2sSP5UDMuLABK+/xoKgmhLnilXwEFAX+C6jOlG9s8N4dE37OZBRB
         VIFW+R3IadpZFH2gZUuh+eo7H2hABXEh/rlBTvYlTot46KNiLTb75OhhJ22bJf0biDvM
         Q2+CJl+WbdYq4zJ4Y7gUeel06oAOGiaX87XgCTT+0107FB5nrjdUTtkX0Tldxk8WznUz
         xg1g==
X-Gm-Message-State: AGi0PuYXbSst2A+YRSv8z4BJHHq9V0/c4Ijb8RDpAOFhF9x7PrvWF5qe
	GJ4sujBZjJ+izYYK+hBJ9/mmDQ==
X-Google-Smtp-Source: APiQypJtvjJEzhQ3IHjsR97nXY/X5+Mcqe2YVVnhcTkS4j8mOhshGgkVFOM17f0YxUmtnPiWj9nvZA==
X-Received: by 2002:a2e:4942:: with SMTP id b2mr7168793ljd.135.1587288733899;
        Sun, 19 Apr 2020 02:32:13 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:2a7:ba19:e1ca:ac28:cceb:53f3? ([2a00:1fa0:2a7:ba19:e1ca:ac28:cceb:53f3])
        by smtp.gmail.com with ESMTPSA id 64sm20404911ljj.41.2020.04.19.02.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 02:32:13 -0700 (PDT)
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <34fe524d-f9f0-ba8a-d5cb-ffbeacf1b5d8@cogentembedded.com>
Date: Sun, 19 Apr 2020 12:32:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418184111.13401-7-rdunlap@infradead.org>
Content-Language: en-US
Message-ID-Hash: X3P3ULGYN467BE3P7JKXHNITKZOMEV42
X-Message-ID-Hash: X3P3ULGYN467BE3P7JKXHNITKZOMEV42
X-MailFrom: sergei.shtylyov@cogentembedded.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X3P3ULGYN467BE3P7JKXHNITKZOMEV42/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGVsbG8hDQoNCk9uIDE4LjA0LjIwMjAgMjE6NDEsIFJhbmR5IER1bmxhcCB3cm90ZToNCg0KPiBG
aXggZ2NjIGVtcHR5LWJvZHkgd2FybmluZyB3aGVuIC1XZXh0cmEgaXMgdXNlZDoNCj4gDQo+IC4u
L2ZzL25mc2QvbmZzNHN0YXRlLmM6Mzg5ODozOiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91
bmQgZW1wdHkgYm9keSBpbiBhbiDigJhlbHNl4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
DQo+IENjOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogIkou
IEJydWNlIEZpZWxkcyIgPGJmaWVsZHNAZmllbGRzZXMub3JnPg0KPiBDYzogQ2h1Y2sgTGV2ZXIg
PGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3Jn
DQo+IC0tLQ0KPiAgIGZzL25mc2QvbmZzNHN0YXRlLmMgfCAgICAzICsrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IC0tLSBsaW51eC1u
ZXh0LTIwMjAwNDE3Lm9yaWcvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiArKysgbGludXgtbmV4dC0y
MDIwMDQxNy9mcy9uZnNkL25mczRzdGF0ZS5jDQpbLi4uXQ0KPiBAQCAtMzg5NSw3ICszODk2LDcg
QEAgbmZzZDRfc2V0Y2xpZW50aWQoc3RydWN0IHN2Y19ycXN0ICpycXN0cA0KPiAgIAkJY29weV9j
bGlkKG5ldywgY29uZik7DQo+ICAgCQlnZW5fY29uZmlybShuZXcsIG5uKTsNCj4gICAJfSBlbHNl
IC8qIGNhc2UgNCAobmV3IGNsaWVudCkgb3IgY2FzZXMgMiwgMyAoY2xpZW50IHJlYm9vdCk6ICov
DQo+IC0JCTsNCj4gKwkJZG9fZW1wdHkoKTsNCg0KICAgIEluIHRoaXMgY2FzZSBleHBsaWNpdCB7
fSB3b3VsZCBwcm9iYWJseSBoYXZlIGJlZW4gYmV0dGVyLCBhcyBkZXNjcmliZWQgaW4gDQpEb2N1
bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdCwgY2xhdXNlICgzKS4NCg0KTUJSLCBT
ZXJnZWkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
