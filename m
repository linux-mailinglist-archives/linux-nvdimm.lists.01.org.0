Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A7A271AA6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 08:04:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B098B14341840;
	Sun, 20 Sep 2020 23:04:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e41; helo=mail-vs1-xe41.google.com; envelope-from=naresh.kamboju@linaro.org; receiver=<UNKNOWN> 
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 595661434183C
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 23:04:29 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a16so7395684vsp.12
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 23:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gmSKhpFY4kTNF3DPRn/4uO6u6dZbhjoQaX0s9W7i2IM=;
        b=nYtofNvodxIDAyZLMUI2rcNLFfTMRH1LBcTAJ8HrhbB2NLSx2bVuOCT+QYikoCeA7t
         Ld15cYB+D7ZgjD2ONWcj2OqcxoABt15HqUl9Wr6vYSziluXmEZd5T/qn3ovoW18lvL+0
         9GxNFwR95z3amyJLydMsfD6AjbMQNRY46l8GuzszwS1sBkoZnviPU3y9du8fLDYa0aoe
         oLZVCrvdkuNDAaf5M2iONVk4vbMyHaHmt1SarI1wMSRtfFJ6f5kZ5UTCOfLNm27wjssj
         Bd8XOiHpUOzpBbsRROFbKkjBZwE0J/LEA8trISJL/3t6GFQldmeWIOWZrSg9BSddoUSc
         RBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gmSKhpFY4kTNF3DPRn/4uO6u6dZbhjoQaX0s9W7i2IM=;
        b=EPM0FAFxOLx3PgkRHZq3nI2P/LFPO7KSG14AUiEtMgavM1TbhdnVPLrOStLu1I7oRc
         1BS1qJLbesu46bDbnXVfhsEYeSTyzS1/cIgaXbn1SOZ18WEeMTJWZHyL4w5j7TjzHeLF
         5tMu4prHoJpxP1K/WnRNnLuRirgoBKeZWYV/p+8PLn5T2lCl7KGXDP9DgtoSnz91maLU
         cZwTe0duif52s64ze6Unt0KC/yDMZiu5QlaEJiJzZVeNBHMvDbw7ra3VFUnkfaq6phi2
         HODxpkY3xBVSe1O8etnlN+BvPOcvK52kgrl5sBiFJc1/RUerT3+uA13N/VwPUQzp69qo
         szWA==
X-Gm-Message-State: AOAM532KCqDWHbJMJvbTnJgE/Hura4Cqg4Qhd7anGi1pJaXjzCSQDd7C
	5ltc2MwgBPYCiIlcVnz58pmyQlBUBQrJOHPo7uCN0A==
X-Google-Smtp-Source: ABdhPJzuk1/PiphSwuUvjP6+E5H+PEm5LcR5lGn9Fq1X93k9XatzTGELxhm95y0PWoUFN4sZmwm7EgBxD7/W71hG544=
X-Received: by 2002:a67:80d2:: with SMTP id b201mr26678854vsd.12.1600668268677;
 Sun, 20 Sep 2020 23:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200921010359.GO3027113@arch-chirva.localdomain>
In-Reply-To: <20200921010359.GO3027113@arch-chirva.localdomain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 21 Sep 2020 11:34:17 +0530
Message-ID: <CA+G9fYtCg2KjdB2oBUDJ2DKAzUxq3u8ZnMY9Et-RG9Pnrmuf9w@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFBST0JMRU06IDUuOS4wLXJjNiBmYWlscyB0byBjb21waWxlIGR1ZSB0byAncmVkZQ==?=
	=?UTF-8?B?ZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmSc=?=
To: Stuart Little <achirvasub@gmail.com>
Message-ID-Hash: NOTNDKXFLRRALFP4ROS2DGG2PMNAYV45
X-Message-ID-Hash: NOTNDKXFLRRALFP4ROS2DGG2PMNAYV45
X-MailFrom: naresh.kamboju@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, kernel list <linux-kernel@vger.kernel.org>, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, mpatocka@redhat.com, lkft-triage@lists.linaro.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NOTNDKXFLRRALFP4ROS2DGG2PMNAYV45/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMSBTZXAgMjAyMCBhdCAwNjozNCwgU3R1YXJ0IExpdHRsZSA8YWNoaXJ2YXN1YkBn
bWFpbC5jb20+IHdyb3RlOg0KPg0KPiBJIGFtIHRyeWluZyB0byBjb21waWxlIGZvciBhbiB4ODZf
NjQgbWFjaGluZSAoSW50ZWwoUikgQ29yZShUTSkgaTctNzUwMFUgQ1BVIEAgMi43MEdIeikuIFRo
ZSBjb25maWcgZmlsZSBJIGFtIGN1cnJlbnRseSB1c2luZyBpcyBhdA0KPg0KPiBodHRwczovL3Rl
cm1iaW4uY29tL3hpbjcNCj4NCj4gVGhlIGJ1aWxkIGZvciA1LjkuMC1yYzYgZmFpbHMgd2l0aCB0
aGUgZm9sbG93aW5nIGVycm9yczoNCj4NCg0KYXJtIGFuZCBtaXBzIGFsbG1vZGNvbmZpZyBidWls
ZCBicmVha3MgZHVlIHRvIHRoaXMgZXJyb3IuDQoNCj4NCj4gZHJpdmVycy9kYXgvc3VwZXIuYzoz
MjU6NjogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhkYXhfc3VwcG9ydGVk4oCZDQo+ICAgMzI1
IHwgYm9vbCBkYXhfc3VwcG9ydGVkKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LCBzdHJ1Y3Qg
YmxvY2tfZGV2aWNlICpiZGV2LA0KPiAgICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fg0KPiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9kYXgvc3VwZXIuYzoxNjoNCj4gLi9pbmNsdWRlL2xp
bnV4L2RheC5oOjE2MjoyMDogbm90ZTogcHJldmlvdXMgZGVmaW5pdGlvbiBvZiDigJhkYXhfc3Vw
cG9ydGVk4oCZIHdhcyBoZXJlDQo+ICAgMTYyIHwgc3RhdGljIGlubGluZSBib29sIGRheF9zdXBw
b3J0ZWQoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsDQo+ICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn4NCj4gICBDQyAgICAgIGxpYi9tZW1yZWdpb24ubw0KPiAgIEND
IFtNXSAgZHJpdmVycy9ncHUvZHJtL2RybV9nZW1fdnJhbV9oZWxwZXIubw0KPiBtYWtlWzJdOiAq
KiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjgzOiBkcml2ZXJzL2RheC9zdXBlci5vXSBFcnJv
ciAxDQo+IG1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDA6IGRyaXZlcnMv
ZGF4XSBFcnJvciAyDQo+IG1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uDQo+DQo+IC0tLSBlbmQgLS0tDQo+DQo+IFRoYXQncyBlYXJsaWVyIG9uLCBhbmQgdGhlbiBs
YXRlciwgYXQgdGhlIGVuZCBvZiB0aGUgKGZhaWxlZCkgYnVpbGQ6DQo+DQo+IG1ha2U6ICoqKiBb
TWFrZWZpbGU6MTc4NDogZHJpdmVyc10gRXJyb3IgMg0KPg0KPiBUaGUgZnVsbCBidWlsZCBsb2cg
aXMgYXQNCj4NCj4gaHR0cHM6Ly90ZXJtYmluLmNvbS9paHhqDQo+DQo+IGJ1dCBJIGRvIG5vdCBz
ZWUgYW55dGhpbmcgZWxzZSBhbWlzcy4gNS45LjAtcmM1IGJ1aWx0IGZpbmUgbGFzdCB3ZWVrLg0K
DQpSZXBvcnRlZC1ieTogTmFyZXNoIEthbWJvanUgPG5hcmVzaC5rYW1ib2p1QGxpbmFyby5vcmc+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
