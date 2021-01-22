Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4B2FFC56
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Jan 2021 06:47:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 548FF100F2263;
	Thu, 21 Jan 2021 21:47:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::446; helo=mail-pf1-x446.google.com; envelope-from=email14+bncbcsy3np4xyfbb7wgvgaamgqeunp2oha@webtotalsolutions.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com [IPv6:2607:f8b0:4864:20::446])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C74DC100EB32E
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 21:47:20 -0800 (PST)
Received: by mail-pf1-x446.google.com with SMTP id y81sf2664004pfb.15
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 21:47:20 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1611294440; cv=pass;
        d=google.com; s=arc-20160816;
        b=iXLLiiIpjOH7WOX2JMoG4pGLVTKiBUuF9avXK/TOw/6XGh3pYEdS5IEINR0gCl478C
         hphnfvoYoiriGccqqkPnfE6MIfuNp8bqzBi48TnLtpNGGSxTz2RrjgWSQdMcKo6VL0Ft
         wrHt1scgWKDRTqft+E6RQz9W4j+ovBGpVdMVaywvgye8Q2HbtMOu5nUwv6CTz1gt8iOs
         8Jp08Z/6jJOzm3Uwzo6tOBf5JRq31euvmN9E32FfyJRPWJ0UpVPF3toXYiXDnbj0DrVK
         r6Rya4vQ+udqrVQIRU2oY4CKcMzOHHzgc/MJfVRoVjoZcvkbZ2gKkXuBqdgNmqh1CdzU
         fIKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-subscribe:list-archive:list-help:list-post
         :list-id:mailing-list:precedence:to:subject:message-id:date:from
         :mime-version:sender:dkim-signature;
        bh=eD8xGjiifykg7XYWDSNyHXQPEkiCmAq9jBAcxMUdSHs=;
        b=p71KRAidUU4emjcyJ4IjxhBfnFwgh7eR0MJZhjxi8T6SvBzQOH15djxnd40nHmrmrg
         XyR/un/2io7ejeUfJPlH2d0SZIjXYUcYhM1WgYlX0E4+yfZQFwG4rNS6ClDv4UA/77n5
         HyAYmiMlBSXHtGib9PFhW4Y1NUySqcVDGw0esJY2aiJo/LFoBteGQOOwseWhFdtdQb5a
         5ZlKqduC6HHkyplKtQMvO7B8mge1HkAdW40xqKTCYaAKN9JJvbMh0s33FCmIszCf7cMU
         QbR9MB/8Q9B2EIp5A4fsCpjF9+uvQ88Ok6f5u0XGt8ag4OUKiOXvkYwhhBVVvQwFhoH2
         Hn2A==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V4Ddqfjc;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webtotalsolutions.com; s=google;
        h=sender:mime-version:from:date:message-id:subject:to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=eD8xGjiifykg7XYWDSNyHXQPEkiCmAq9jBAcxMUdSHs=;
        b=DWBdS6ZJai2g2O+AkBXqAt3BE/UI00aI3mqYWpnioGVNoz8S/LZpX0XKHTaxCbYkUR
         u1ALizfgXUEvPZiRgmPte64a2DKDKJgtxXEN4xcBtQyFiRmN4dINF00WmnYpoSpsP8rl
         427qGQSHAmNzfO3GM91ziSfgCclg6kibi7A6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=sender:x-gm-message-state:mime-version:from:date:message-id:subject
         :to:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe;
        bh=eD8xGjiifykg7XYWDSNyHXQPEkiCmAq9jBAcxMUdSHs=;
        b=jjQxEveElLdF7Loh1PzoiZBWHmBQGuqW+CwpNFw6HkJcJChIE2UoXIAA/NCAzIgpw0
         ZNq9twyLcBkaYk9/t2NZvmim/ZY5jnvm32zUEGuhDmfuTM2qbsjKXfGSGZHeJLTyxRRD
         6l0etbUwv7dkAvUrqy3AHDO7VEkpgJ9UpHXe8AyP0T1dKMb0nCANuG+DkP+38Gh9Cjox
         /F7nn+R6AHuIgxUzIBTY6jFPY0dNCzEmHCSxj/Y2sBj2K8334XdmFQIIS61an30ZmIsA
         B+Nqes0WmQb7y+iJvHx8Lqg4XLVXbG3sxK6Iu/2rDaMccR5of2xNPs2mhkigrHhUfaq/
         omNA==
Sender: email14@webtotalsolutions.com
X-Gm-Message-State: AOAM533qkMfCfIHAnRvTy1N+bmaFexxjuyOeJdU/vqCFbem/KAl17/24
	ud+/lTK91G61ydD/G4nJzdwwdw==
X-Google-Smtp-Source: ABdhPJx8361GgbqVI+tBA50v/c1mdnwGoiwXpCAHKKxmTplWRABtqCBHiUmZiZGYsJtPpPQ8j41Big==
X-Received: by 2002:a17:90a:a88e:: with SMTP id h14mr3377756pjq.59.1611294440248;
        Thu, 21 Jan 2021 21:47:20 -0800 (PST)
X-BeenThere: email14@webtotalsolutions.com
Received: by 2002:a17:902:b107:: with SMTP id q7ls2183296plr.8.gmail; Thu, 21
 Jan 2021 21:32:45 -0800 (PST)
X-Received: by 2002:a17:90a:1b29:: with SMTP id q38mr3373907pjq.223.1611293565486;
        Thu, 21 Jan 2021 21:32:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1611293565; cv=none;
        d=google.com; s=arc-20160816;
        b=HcnU2coR9EKVxDI0oFVX3TdiH9NEOLbt6pU3qg3Wvthpd10HSCcXUNUfoPip/jDc0F
         neQx2Jszl37uGlGmkyIhmwI+2Qx72lpB9/7jWQBN+V3ANRksDGf37VsFWoyflnwmIBC1
         npngMNFUkee71R8oTypioJUwxCjf37vg1AAJp9gr52M3tMZkZbOhR0HWkFITUpfZv6ft
         wWigjFfBBeENRPVyRmVlmrlqYwbFpYfqjpc7ifgn4S1FMpo+hqttkyCV/mgQ6xGV+R7Z
         twTzlOjpGcupoUFhJBcYe8Zw2QKhXrXo49LupgdlgDjkizth0e7k8R+YUSCcZh7tcBSJ
         XbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eD8xGjiifykg7XYWDSNyHXQPEkiCmAq9jBAcxMUdSHs=;
        b=wfbt4vXPyzLuFtTQIA1cvO9thH11Gkm58eZyu9XgZyMUfmH7TYfYK6Ey8a7IsmvrZJ
         VuUHCqOgcw8sGBpf23IB5y06ERLrie5tyiSubZxtXL/fS8/DsFdHzBCqa6Fcsj300GVr
         4TuoWZS2QadSYiGqLTWiwWtJ872aVPXpDndL/FcKbzMgWNrwxFl9bflhHSYN2C3PwYda
         fWYtLVtsMBSh90sEEU/fDLWC58dnm/fmcuwBBsTwQxn9rnpvD63tnuxj0jmN23bDfdgD
         /aCNyIcBhq6I6ZOy77v/+cH3+AtOiCK9a5o3v7R4hzpLbpmCEN4tu3sDC4gnuMzbJPnO
         9WjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=V4Ddqfjc;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id m5sor4412727plt.3.2021.01.21.21.32.45
        for <email14@webtotalsolutions.com>
        (Google Transport Security);
        Thu, 21 Jan 2021 21:32:45 -0800 (PST)
Received-SPF: pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) client-ip=209.85.220.41;
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id
 p9-20020a1709026b89b02900dafc41baecmr3014714plk.39.1611293565051; Thu, 21 Jan
 2021 21:32:45 -0800 (PST)
MIME-Version: 1.0
From: Annu Taneja <lissajohnson759@gmail.com>
Date: Fri, 22 Jan 2021 11:02:38 +0530
Message-ID: <CAPhvtKxj-DPrfj=PEBF6aQ5phd6078Qbm7N1-3dzYvR=jfbbrw@mail.gmail.com>
Subject: Revamp Existing website Affordable cost ...!!!
To: undisclosed-recipients:;
X-Original-Sender: lissajohnson759@gmail.com
X-Original-Authentication-Results: mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=V4Ddqfjc;       spf=pass
 (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as
 permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;       dmarc=pass
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list email14@webtotalsolutions.com; contact email14+owners@webtotalsolutions.com
X-Spam-Checked-In-Group: email14@webtotalsolutions.com
X-Google-Group-Id: 1036746787170
Message-ID-Hash: 6NJLWPZBN7QBOTSPAQZO6N5A6PXTIPDK
X-Message-ID-Hash: 6NJLWPZBN7QBOTSPAQZO6N5A6PXTIPDK
X-MailFrom: email14+bncBCSY3NP4XYFBB7WGVGAAMGQEUNP2OHA@webtotalsolutions.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6NJLWPZBN7QBOTSPAQZO6N5A6PXTIPDK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSBob3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KDQoNCkhlcmUgSSB3b3VsZCBsaWtlIHRvIGdy
YWIgeW91ciBhdHRlbnRpb24gYWJvdXQgb3VyIGJlc3QgSVQgc2VydmljZXMgd2hpY2gNCndpbGwg
aW1wcm92ZSB5b3VyIG9ubGluZSB0cmFmZmljICYgc2FsZXMgYXQgYQ0KDQoNCg0KZnJhY3Rpb24g
b2YgdGhlIGNvc3QuDQoNCg0KDQpXZSBvZmZlciBmb2xsb3dpbmcgc2VydmljZXMgd2l0aCBzdWl0
YWJsZSBwcmljZTotDQoNCg0KDQoxLiBTRU8g4oCTIChGdWxsIFNFTyBQYWNrYWdlcyB3aXRoIHBs
YW4gYW5kIGFjdGl2aXRpZXMpDQoNCjIuIFNNTyDigJMgKEZhY2Vib29rLCBUd2l0dGVyLCBMaW5r
ZWRJbiwgWW91VHViZSAmIE15U3BhY2UgTWFya2V0aW5nLCBldGMpLg0KDQozLiBQUEMg4oCTIChQ
YXkgcGVyIENsaWNrKS4NCg0KNC4gV2ViIERlc2lnbmluZyDigJMgKEhUTUwsIEpRVUVSWSwgSmF2
YVNjcmlwdCwgSFRNTCwgTG9nbyBhbmQgRmxhc2ggRGVzaWduKQ0KDQo1LiBXZWIgRGV2ZWxvcG1l
bnQg4oCTIChFLWNvbW1lcmNlLCBQSFAgJiBGbGFzaCBEZXZlbG9wbWVudCkNCg0KNi4gTW9iaWxl
IFNpdGUgRGV2ZWxvcG1lbnQg4oCTIChBbmRyb2lkIEFwcHMgRGV2ZWxvcG1lbnQsIGlQaG9uZSBB
cHBzDQpEZXZlbG9wbWVudCwgQXBwcyBHVUkgZGVzaWducykNCg0KDQoNCkFyZSB5b3UgbG9va2lu
ZyB0byBnZXQgYSBuZXcgd2Vic2l0ZSBmb3IgeW91ciBidXNpbmVzcywgdXBncmFkZSB5b3VyDQpl
eGlzdGluZyB3ZWJzaXRlLCBvciBtYWtlIGl0IG1vcmUgZmluZGFibGUgb24gR29vZ2xlLA0KDQoN
Cg0KWWFob28sIGFuZCBCaW5nPw0KDQoNCg0KSWYgc28sIHRoZW4gZHJvcCB1cyBhIGxpbmUgYW5k
IHdlIHdpbGwgZ2V0IGJhY2sgdG8geW91IHNvb24gd2l0aCBtb3JlDQpkZXRhaWxzLg0KDQoNCg0K
QmVzdCBSZWdhcmRzLA0KDQpBbm51DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
