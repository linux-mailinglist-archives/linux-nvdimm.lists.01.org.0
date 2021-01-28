Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21B0306C4B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 05:36:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10E75100F224E;
	Wed, 27 Jan 2021 20:36:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=email14+bncbcsy3np4xyfbb47szcaamgqeafhssqy@webtotalsolutions.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com [IPv6:2607:f8b0:4864:20::448])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 494CA100F224C
	for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 20:36:00 -0800 (PST)
Received: by mail-pf1-x448.google.com with SMTP id t16sf2736819pfh.22
        for <linux-nvdimm@lists.01.org>; Wed, 27 Jan 2021 20:36:00 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1611808559; cv=pass;
        d=google.com; s=arc-20160816;
        b=Z+rViSoAI8hq8aQhUQ9IOm9iv9z145o6Wb6q16LzuXL4xIjBb1R/dcmWPqTBb6v1mm
         gxIqBtrWG9U76qXax4Bh3/Sbd+ElW06oCUUPRubj51RagudvQ6CD1HJBEgfYG41piFIN
         dWKjCeh9mdkfknujYuuWX9bGtMLgbpCJM2q+IVCFrdJS1LFQ6mZvlf7lAZZ8IiyeeT9u
         9yTUqAm8jo4sEUMNY7b6+94x4sbZLoDP8Mk3yDdi1nJsJa88wIepOXYfgWegsZ7wcWJZ
         /ozgEM0LbBXI6jZCzx+jEef8AxeHPc+LA7MybW0HU3pLy0x6Hzv+S3c5pvfOVi56Fytq
         7fpg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-subscribe:list-archive:list-help:list-post
         :list-id:mailing-list:precedence:to:subject:message-id:date:from
         :mime-version:sender:dkim-signature;
        bh=81Tg4+EoPbeHSoofV3T4S9z6cZSVEVZlC5QjzvWgtzs=;
        b=knulDmKIHU15i0wkcQQnGAz1XqYa7ZQilRTLHZ6mN+7mKIzUEhQ8uB4kDKYgD4g5gd
         geMSVY/SLSJxEUryH8hzyJYl5i1K6dw3Tm1aEAJ1oF4JfONpPHOlbQYL1Je0SJkmlqTQ
         K41URxeKlB7C8DJVwJf4yehB3EaK8gS3cNRzisDYvDGe8uEpKhK+006CQgPRk9sGg5u0
         YNxgS88NtsCs6hkvXeyerpuxUrENBrZZxWvE8NWykh/7x9TIAdxx3FSHg9XedyLCVwSj
         F3qvzKYCycrD8qz+oB8R/1Y/trdoRmbcSxQcW7Ui2618OcfUtYuhuuoBBs1fSN7Kmokh
         yQbg==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oclJ6hy+;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webtotalsolutions.com; s=google;
        h=sender:mime-version:from:date:message-id:subject:to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=81Tg4+EoPbeHSoofV3T4S9z6cZSVEVZlC5QjzvWgtzs=;
        b=FooAeTHvWmYaz0yMXNPVupRgDMjQh5UdlcJ7Do4kLVcFPz+9n2Zv0+MB3OBlWf5Zy5
         0qkttYjtoMIqciLmL1pkIpcle63OhNvHxnSz60IRflxVkDzjr4wdRWZXhm7VwieTzZAl
         oGisczOFsGvA37WeOyFhyx1+9Mxyw5kDOIul0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=sender:x-gm-message-state:mime-version:from:date:message-id:subject
         :to:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe;
        bh=81Tg4+EoPbeHSoofV3T4S9z6cZSVEVZlC5QjzvWgtzs=;
        b=DUwX/gIoQY0nQbO6xl/y0P+wBlEB2Nq29oTFPkGLiw+k5CIq10SkR+eryVdT9lUVLC
         Hd3jrHeDZJ8DZxWi75gM86nUcxxEWI2AK8xnvtUVRppp3IYYXu4PThusxtUhg5jPQyVo
         yndIe67XiBQFgKhsvn0jcFnI9Zv7bjpK6zhV23pzd9S/Q0mUMnCH7mK4SWLE9S7EaiPi
         9t6IfBrjwKkKTqTTWO4QqFQruNqqufjNQHpqbCGk4eO/E/S9hyL6jJwEPt7W9pooykaZ
         itbZA/gI5GGouIiVf8dB2yit8TPP1Wk2C7ucbV6lyd9tpK4VEn00cP0NgDJ3G7VcGC3D
         PuNg==
Sender: email14@webtotalsolutions.com
X-Gm-Message-State: AOAM530Wg+g/yju0pEdXye+6MhgjCaOpGqoAD1sDbwCngvKM9dpE6ELD
	PIze1UL5g0h34rNh7MYBODSXxw==
X-Google-Smtp-Source: ABdhPJxpJMH7O2kISK9TFA/LJdLNxTW+cdtjn8aqrGZRrkmCno2wd9WSsQ4Wfb9ZFi4jwsuB2XnOAQ==
X-Received: by 2002:a17:90b:4905:: with SMTP id kr5mr9299381pjb.1.1611808558333;
        Wed, 27 Jan 2021 20:35:58 -0800 (PST)
X-BeenThere: email14@webtotalsolutions.com
Received: by 2002:a62:3583:: with SMTP id c125ls1707362pfa.2.gmail; Wed, 27
 Jan 2021 20:11:30 -0800 (PST)
X-Received: by 2002:a65:5b0c:: with SMTP id y12mr14804170pgq.407.1611807090773;
        Wed, 27 Jan 2021 20:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1611807090; cv=none;
        d=google.com; s=arc-20160816;
        b=wkkXbOtTg+z8vXdGvSkhO0hNqy69YBFm3sh9o85olNgl1+ogAiH2ut0xHfh1SiPRsn
         qgJS34XAKpmTlhvB0TcODfurlNqzaBEKqx4HFWig+qUXOUyxqeuQnlt/nkp4I7xM5Bra
         tX0g6VMzhc8+aBC8ZFCtCSE96MH5cGpt4kvDFmKIvnqaiJdYbfCMGesuPqXLUSgjKqcU
         Wmb9jt3YHSAuhQPE12SBkS/iFT0zhTYrGgAwgaxep50Y3uG+EaUrZpykFTgpPOShO8CO
         X+o3cI3C80AAby03eqc7wDyy8p8ENgW2fOZjHFv3rkrdS4iobWEJUcBDBFvEf+7QfOPu
         TCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=81Tg4+EoPbeHSoofV3T4S9z6cZSVEVZlC5QjzvWgtzs=;
        b=KknH8obaBIorSVW+hMTs6ciRSdeXqh9QsEW21ALTFIkBavh29PmXCVdKA5LOgjZJ/j
         GwVTpNJEfvdpJzS4DBP+w5ve/Gvmy3VsyHJCYYn17O4bSbTrGW5OYnhJII3G0iQPqy2M
         OOe7FOvQCXB7FrYfmA/DiO0QjM+n0g2+2L59jsEYZ9oJsUKqisTKslKkmJm82nWkf+H5
         6Ac6sNMDwXVcJM0yM4Sv2b/dXCH1PKWQ2xXglsgIDs1x5jqjshezd4S5zBwrnTfp9Rmh
         uu7xQWij7FpvX/3KqfTKlv57t1J6Ueg6eSj0R6QwuP0LSLECI2n7n+6zQhu8DF1NUhXN
         k/Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oclJ6hy+;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id u11sor2152864pgh.81.2021.01.27.20.11.30
        for <email14@webtotalsolutions.com>
        (Google Transport Security);
        Wed, 27 Jan 2021 20:11:30 -0800 (PST)
Received-SPF: pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) client-ip=209.85.220.41;
X-Received: by 2002:a63:1214:: with SMTP id h20mr14217605pgl.379.1611807090335;
 Wed, 27 Jan 2021 20:11:30 -0800 (PST)
MIME-Version: 1.0
From: Annu Taneja <lissajohnson759@gmail.com>
Date: Thu, 28 Jan 2021 09:41:22 +0530
Message-ID: <CAPhvtKz=d9Fz6T1xgt_pBHt_AK6T=3KVV_b5vF-rrOcLSAgNbQ@mail.gmail.com>
Subject: Reminder : Native and Hybrid Mobile Application Development ...
To: undisclosed-recipients:;
X-Original-Sender: lissajohnson759@gmail.com
X-Original-Authentication-Results: mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=oclJ6hy+;       spf=pass
 (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as
 permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;       dmarc=pass
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list email14@webtotalsolutions.com; contact email14+owners@webtotalsolutions.com
X-Spam-Checked-In-Group: email14@webtotalsolutions.com
X-Google-Group-Id: 1036746787170
Message-ID-Hash: EYL4LAN4JFOOMRFFGCDDFP45GZXWHNPL
X-Message-ID-Hash: EYL4LAN4JFOOMRFFGCDDFP45GZXWHNPL
X-MailFrom: email14+bncBCSY3NP4XYFBB47SZCAAMGQEAFHSSQY@webtotalsolutions.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EYL4LAN4JFOOMRFFGCDDFP45GZXWHNPL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCg0KDQpJIHVuZGVyc3RhbmQgeW91IG11c3QgYmUgcXVpdGUgYnVzeSB3aXRoIHlv
dXIgd29yay4NCg0KDQoNCkkganVzdCB3YW50IHRvIGJlIHN1cmUgaWYgeW91J3ZlIHJlY2VpdmVk
IG15IGxhc3QgZW1haWwuIExldCBtZSBrbm93IGlmIHlvdQ0KbmVlZCBvdXIgc2VydmljZXMuIFdl
IGFyZSBvZmZlcmluZyB0aGUgYmVzdCBxdW90ZSBpbiB0aGUgaW5kdXN0cnkgZm9yIG91cg0KcHJl
bWl1bSBxdWFsaXR5IHNlcnZpY2VzLg0KDQoNCg0KbG9va2luZyB0byBoZWFyIGZyb20geW91IHNv
b24uLi4NCg0KDQoNClRoYW5rIHlvdSwNCg0KQW5udQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQoNCg0KDQpIaSwNCg0KQXJlIHlvdSBzdHJ1Z2dsaW5nIHdvcmtpbmcgd2l0aCBmcmVl
bGFuY2UgZGV2ZWxvcGVycy9kZXNpZ25lcnM/DQoNCipSZWFjaGluZyBvdXQgdG9kYXkgdG8gc2Vl
IGlmIGl0IHdvdWxkIGJlIHdvcnRoIGEgcXVpY2sgY29udmVyc2F0aW9uIGFib3V0OioNCg0Kwrcg
ICAgICAgICAgICAgV2Vic2l0ZSBkZXNpZ24gJiBkZXZlbG9wbWVudCDigJMgbWFkZSB0byBvcmRl
ciB3ZWJzaXRlIGZvciB5b3VyDQpidXNpbmVzcw0KDQrCtyAgICAgICAgICAgICBNb2JpbGUgYXBw
IGRldmVsb3BtZW50IOKAkyBhbiBlZGdlIG92ZXIgeW91ciBjb21wZXRpdGlvbg0KDQrCtyAgICAg
ICAgICAgICBPZmZzaG9yZSB3ZWIgZGVzaWduICYgZGV2ZWxvcG1lbnQgc3VwcG9ydCDigJMgY29z
dCBhZHZhbnRhZ2UsDQp0byBidWlsZCBhZGRpdGlvbmFsIGRlbGl2ZXJ5IGNhcGFjaXR5DQoNCipQ
cm9ncmFtbWluZyBsYW5ndWFnZXMgdGhhdCB3ZSB3b3JrIHdpdGg6Kg0KDQrCtyAgICAgICAgICAg
ICBQSFAsIC5OZXQsIFB5dGhvbiwgQW5kcm9pZCwgaU9TDQoNCipUaGUgZnJhbWUgd2Ugc3VwcG9y
dDoqDQoNCsK3ICAgICAgICAgTGFyYXZlbCwgU3ltZm9ueSwgQ29kZUlnbml0ZXIsIFlpaSwgQ2Fr
ZVBIUCwgWmVuZCwgQXNwLm5ldCBNVkMNCg0KKkNNUyB3ZSBzdXBwb3J0OioNCg0KwrcgICAgICAg
ICBXb3JkUHJlc3MsIEpvb21sYSwgTWFnZW50bywgRHJ1cGFsLCBPcGVuQ2FydCwgWmVuQ2FydCwg
UHJlc3Rhc2hvcA0KDQpXZSBoYW5kcGljayBvdXIgcmVzb3VyY2VzIGFuZCBlbnN1cmUgdGhhdCBl
YWNoIG9uZSBmb2xsb3dzIGluZHVzdHJ5IGJlc3QNCnByYWN0aWNlcyBhbmQgbWVldHMgaGlnaC1x
dWFsaXR5IHN0YW5kYXJkcyB0aHJvdWdoIG91ciB3b3JrIHByb2Nlc3MuDQoNCipJZiB5b3UncmUg
bm90IGludGVyZXN0ZWQsIEknZCBhcHByZWNpYXRlIGEgcXVpY2sgIm5vIHRoYW5rIHlvdSIgc28g
SSBjYW4NCm5vdGUgdG8gbm90IGZvbGxvdyB1cC4qDQoNCipLaW5kIFJlZ2FyZHMsKg0KDQoqQW5u
dSoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
