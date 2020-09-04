Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532C25DBD9
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Sep 2020 16:34:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 861CA13AABF96;
	Fri,  4 Sep 2020 07:34:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=jaxon.leo@b2bexpodata.com; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F74413AABEDC
	for <linux-nvdimm@lists.01.org>; Fri,  4 Sep 2020 07:34:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id h11so6496130ilj.11
        for <linux-nvdimm@lists.01.org>; Fri, 04 Sep 2020 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=b2bexpodata.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZhKdBCzikTcnelZ8BjOZz239bWBLz0RaoVrw2yd1GZs=;
        b=tFw2nyNQ0WY/4MFJEfhZgFcaGIzKJgP6vyjVGxQb5oMd08USKEQNn+6n2iZ7sD53Qh
         TOWexWZcpQeasfvBhNUSD9BVL9MZ6ErCTOZabhh48dPp4vpI0Ji96k6BkS2fdyDJpnOS
         FtB2SRiHswwv0TuTaXN/QF/ZdlIe5cJUkCFMQWdtE7TDYfZIP1qPMOs6bbrkdGAyZP+i
         dhOoaQRPbkBSqo2wpxMT2fA/yELIkt2PK6oLr++Mct00uTy0DU6BztYMrQK3nZIAioJy
         JhCJeWjQg93a2i9eSHdNmB+vF1yf2oFtwkfrAjqe64DL8IOSN6cvmEzxg6nBYnJV1M5/
         KHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZhKdBCzikTcnelZ8BjOZz239bWBLz0RaoVrw2yd1GZs=;
        b=Kmro7ljUi4t3yWqdIcxShgBWPZGz1/x3pB5QMuHVQa8/9EoXvcsr7UZzX8NHykNP0m
         E0G18J6NrVxKdH6qFcioaqPLK4gpHAKz8fKi1nKYRHlLrBVTnNF5GAOb6qOtVwox3wUX
         R+s43RKgRHukyYAZ81u0alGdKSdf5NtHZiR5K5GAtBcZ5arBOagHc7thFtjHdh6c/iCu
         c/obI25q3SmqUtj7XQ9tF9Kmil9XPGHCKOLLTUtKHqLnhS1u+UQFOIdfahf19zoYmFvP
         IYEoG9gwjti/eSUUBkg6W49jooUzly2nEXPfTjHEtiYo+KdpLILS9V7IWvi1c/WbuGPB
         eenA==
X-Gm-Message-State: AOAM531oI9Jl1eKWPg1P892R/UGgnWwQ6T9aG5+jydfMBQSN69yMKWi9
	ZKmCHq5O6CTV0xLxQ+n3VCvlS7/3gwfAcD4IEFmA+Q==
X-Google-Smtp-Source: ABdhPJywKoeif0uALy9oTpaH3UtPAVOopnJNmMTi0vjfgACo0CWcFFs+E10YtSgmBw38K6mh9DZmXLLNt7HHhd9NSRA=
X-Received: by 2002:a05:6e02:f91:: with SMTP id v17mr8605630ilo.82.1599230060723;
 Fri, 04 Sep 2020 07:34:20 -0700 (PDT)
MIME-Version: 1.0
From: Jaxon Leo <jaxon.leo@b2bexpodata.com>
Date: Fri, 4 Sep 2020 20:05:03 +0530
Message-ID: <CADRtXmQyuVKugSgAdDGCwV6O=rPP+B70x=Q=g9tijW0S7pt2Yw@mail.gmail.com>
Subject: Hardware Industry (Machinery, Tools & Supplies) Updated Data Base
To: undisclosed-recipients:;
Message-ID-Hash: JH76HVG2WEPP6U4T6JL2NUUX3QUUJMLU
X-Message-ID-Hash: JH76HVG2WEPP6U4T6JL2NUUX3QUUJMLU
X-MailFrom: jaxon.leo@b2bexpodata.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JH76HVG2WEPP6U4T6JL2NUUX3QUUJMLU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkhvcGUgeW91IGFyZSBkb2luZyB3ZWxsLA0KDQpJIGFtIHdyaXRpbmcgdG8gY2hlY2sg
aWYgeW91IGFyZSBpbnRlcmVzdGVkIGluIGFjcXVpcmluZyB0aGUgQjJCIERhdGFiYXNlDQpvZiAq
IEhhcmR3YXJlIEluZHVzdHJ5IChNYWNoaW5lcnksIFRvb2xzICYgU3VwcGxpZXMpICpmcm9tIGFj
cm9zcyB0aGUgd29ybGQuDQoNCldlIGhhdmUgYSBodWdlIHVwZGF0ZWQgZGF0YWJhc2UgZnJvbSBh
bGwgaW5kdXN0cmllcy4NCg0KUGxlYXNlIGxldCBtZSBrbm93IHlvdXI6DQoNCjEuIFRhcmdldGVk
IEF1ZGllbmNlLg0KMi4gVGFyZ2V0ZWQgR2VvZ3JhcGh5Lg0KMy4gVGFyZ2V0ZWQgSW5kdXN0cnku
DQoNCg0KDQpJZiB5b3UgYXJlIGludGVyZXN0ZWQgZHJvcCBtZSBhIGxpbmUgYW5kIGdldCBiYWNr
IHRvIHlvdSB3aXRoIGNvdW50cywNCnByaWNpbmcgYW5kIG90aGVyIGluZm9ybWF0aW9uIGZvciB5
b3VyIHJldmlldy4NCg0KSWYgeW91IHRoaW5rIEkgc2hvdWxkIGJlIHRhbGtpbmcgdG8gc29tZW9u
ZSBlbHNlLCBwbGVhc2UgZm9yd2FyZCB0aGUgZW1haWwNCnRvIHRoZSBjb25jZXJuZWQgcGVyc29u
Lg0KDQpMb29raW5nIGZvcndhcmQgdG8gaGVhcmluZyBmcm9tIHlvdS4NCg0KQmVzdCBSZWdhcmRz
LA0KDQoNCipKYXhvbiBMZW8gQjJCIEV4cG8gRGF0YSBNYXJrZXRpbmcgYW5kIGNvbW11bmljYXRp
b24qDQoNCipJZiB5b3UgZG9u4oCZdCB3aXNoIHRvIHJlY2VpdmUgZW1haWxzIGZyb20gdXMgcmVw
bHkgYmFjayB3aXRoIOKAnFVuc3Vic2NyaWJl4oCdDQpTdGF5IHNhZmUtKg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcg
bGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4g
ZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
