Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAA1AF54C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 00:20:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BE3510FC62F3;
	Sat, 18 Apr 2020 15:20:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.215.196; helo=mail-pg1-f196.google.com; envelope-from=bart.vanassche@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B07C10FC62EB
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 15:20:42 -0700 (PDT)
Received: by mail-pg1-f196.google.com with SMTP id n16so3089809pgb.7
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 15:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lJaFjYcZIrKINzwKQy1R3xgWxtfsMwR6sB1R/eMtwU=;
        b=tj9PZBv28nc84j4ACv7N7eB1Wyi67nWVoF/3O5PfNr9X97lr+hCeIjqIgI7cfcHkyE
         UCDWExX6G3hE69hbOzTJH6oVw734+rvF1ccdz5Etf7VkEbymbczx7e54sFtmJW9DqOLL
         ck5LTaCGxhZGJzJWkD4HQgnJz/bs2W54palmmPqBoJO9j8Fj92An0V4aiwW2o4kC9get
         /S5Mov2XYUUaVg1EVepHjmNMolRpj0Nbs0ZvN2j/flr4kMyrPBEzlwP+Kn8+9ibSVLob
         lrNK+21kXbu9W3Rc1fScDPXadN1VU9w5sW2VPwG9AZ0ihd8i5Emv4AuBD82sl/5HkUpx
         QIBA==
X-Gm-Message-State: AGi0PuZqNP8E61wEb7idMsCu1bKxMxr63A2Mzo7RHTdyOJLdH+tkuMa+
	cJSwp+Z0OrWY8zLip1C0JIo=
X-Google-Smtp-Source: APiQypKrKkW1CP9zvg0HpaxgHFnkJUL1mC4k4+CRal+TZ48iPbm1ertqTrjT7jN+bYBQFGm5GWkzYw==
X-Received: by 2002:a63:554b:: with SMTP id f11mr3245678pgm.343.1587248435352;
        Sat, 18 Apr 2020 15:20:35 -0700 (PDT)
Received: from [100.124.15.238] ([104.129.198.61])
        by smtp.gmail.com with ESMTPSA id b189sm14519134pfb.163.2020.04.18.15.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 15:20:34 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
Date: Sat, 18 Apr 2020 15:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418184111.13401-2-rdunlap@infradead.org>
Content-Language: en-US
Message-ID-Hash: RBHV2QPYBHELITCVGLPZEWZGJW2JBWMZ
X-Message-ID-Hash: RBHV2QPYBHELITCVGLPZEWZGJW2JBWMZ
X-MailFrom: bart.vanassche@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RBHV2QPYBHELITCVGLPZEWZGJW2JBWMZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gNC8xOC8yMCAxMTo0MSBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiAtLS0gbGludXgtbmV4
dC0yMDIwMDMyNy5vcmlnL2luY2x1ZGUvbGludXgva2VybmVsLmgNCj4gKysrIGxpbnV4LW5leHQt
MjAyMDAzMjcvaW5jbHVkZS9saW51eC9rZXJuZWwuaA0KPiBAQCAtNDAsNiArNDAsMTQgQEANCj4g
ICAjZGVmaW5lIFJFQUQJCQkwDQo+ICAgI2RlZmluZSBXUklURQkJCTENCj4gICANCj4gKy8qDQo+
ICsgKiBXaGVuIHVzaW5nIC1XZXh0cmEsIGFuICJpZiIgc3RhdGVtZW50IGZvbGxvd2VkIGJ5IGFu
IGVtcHR5IGJsb2NrDQo+ICsgKiAoY29udGFpbmluZyBvbmx5IGEgJzsnKSwgcHJvZHVjZXMgYSB3
YXJuaW5nIGZyb20gZ2NjOg0KPiArICogd2FybmluZzogc3VnZ2VzdCBicmFjZXMgYXJvdW5kIGVt
cHR5IGJvZHkgaW4gYW4g4oCYaWbigJkgc3RhdGVtZW50IFstV2VtcHR5LWJvZHldDQo+ICsgKiBS
ZXBsYWNlIHRoZSBlbXB0eSBib2R5IHdpdGggZG9fZW1wdHkoKSB0byBzaWxlbmNlIHRoaXMgd2Fy
bmluZy4NCj4gKyAqLw0KPiArI2RlZmluZSBkb19lbXB0eSgpCQlkbyB7IH0gd2hpbGUgKDApDQo+
ICsNCj4gICAvKioNCj4gICAgKiBBUlJBWV9TSVpFIC0gZ2V0IHRoZSBudW1iZXIgb2YgZWxlbWVu
dHMgaW4gYXJyYXkgQGFycg0KPiAgICAqIEBhcnI6IGFycmF5IHRvIGJlIHNpemVkDQoNCkknbSBs
ZXNzIHRoYW4gZW50aHVzaWFzdCBhYm91dCBpbnRyb2R1Y2luZyBhIG5ldyBtYWNybyB0byBzdXBw
cmVzcyANCiJlbXB0eSBib2R5IiB3YXJuaW5ncy4gQW55b25lIHdobyBlbmNvdW50ZXJzIGNvZGUg
aW4gd2hpY2ggdGhpcyBtYWNybyBpcyANCnVzZWQgd2lsbCBoYXZlIHRvIGxvb2sgdXAgdGhlIGRl
ZmluaXRpb24gb2YgdGhpcyBtYWNybyB0byBsZWFybiB3aGF0IGl0IA0KZG9lcy4gSGFzIGl0IGJl
ZW4gY29uc2lkZXJlZCB0byBzdXBwcmVzcyBlbXB0eSBib2R5IHdhcm5pbmdzIGJ5IGNoYW5naW5n
IA0KdGhlIGVtcHR5IGJvZGllcyBmcm9tICI7IiBpbnRvICJ7fSI/DQoNClRoYW5rcywNCg0KQmFy
dC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
