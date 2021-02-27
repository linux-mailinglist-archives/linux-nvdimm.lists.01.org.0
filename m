Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96848326BC6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Feb 2021 06:27:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBE27100EC1CD;
	Fri, 26 Feb 2021 21:27:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=email14+bncbcsy3np4xyfbbr5l46aqmgqexttjabq@webtotalsolutions.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF9CA100ED4BC
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 21:27:23 -0800 (PST)
Received: by mail-pg1-x546.google.com with SMTP id i10sf7378495pgm.7
        for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 21:27:23 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; t=1614403643; cv=pass;
        d=google.com; s=arc-20160816;
        b=PdU9TKt2HWT7xs+RrB64yPY8y8gMC/yAARZmjjIYjK0F+AdaayxSGpzQSvRrYfAPrr
         UfydhwWxFvdAFhaTVTy3/mn4kltZbyrJ65BGeB/qiAe8hHW+cB68OnKZCXzVV1QuH3nF
         Ee+wbkHIkDFVXzKeKPKwwyQzedEMF7tVPH0YwQZzHnCYCZpquZJuZDfDI7CIuJCCQXh3
         CMUtsY2DJWFD5tWyJbwm2ajNolyhLJEi6Uv6IJgbM9iSBBXxHqe5fQR+X91omKPYfhih
         HTjrTlYAUtemliJuiW8YygWGdryGsaaXAD4FJSUMT0RRjsOnNzoZq3Q8NUxBpQZEzG6C
         77zg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-subscribe:list-archive:list-help:list-post
         :list-id:mailing-list:precedence:to:subject:message-id:date:from
         :mime-version:sender:dkim-signature;
        bh=sPFPP6wKqWUTn+63qFfGjxHn+5lG2lDmzhqnv4/GhWE=;
        b=0pNpZO/DMSaRg/BpdFhekFkRMPN5W0BLoE03TlDVLijPKsi5rJ5uyS2ZDMB9mZS9J9
         4wypMw0sD5F96znU2Yicp6I8YhQe0NKNz/Owo5bwIr8CU8kboI8aRHTn5UG9AP2VC5PC
         kHFebC4gqJxk6vZOIBigsMvtlfqSXOxJ5bwHRKymkWDY7Mg+yDYyKbrW34CnT0qCSMcy
         x/wtc3j5DfqEyWembcv7cmlHqgwcFClP3J4f0K3o5XTUSQD1R238R0fW77cfwGRDdXZQ
         RSMC8wcjXqFbEx5539tfmphgRBNATPv5HIygWz173dilCgywm6ns7MLEn5Ak+8uTQvBk
         Uc+g==
ARC-Authentication-Results: i=2; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qQza03E7;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webtotalsolutions.com; s=google;
        h=sender:mime-version:from:date:message-id:subject:to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe;
        bh=sPFPP6wKqWUTn+63qFfGjxHn+5lG2lDmzhqnv4/GhWE=;
        b=NFN1Ji8WMTNKU96LQriI81LByLF+VtdwCPThb3/c4D0QY084R2PpjQi8t0PFv6bNha
         ChAlKcP5TErD3+4gB0wx0wFwHjeiFiTe8fMAhMzKlq/oIGcNQcDZoVYCshmm1Hs2wlp3
         YZNgzIlYCbd7U7YhQof0xBhLLcOGiBiW3wSAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=sender:x-gm-message-state:mime-version:from:date:message-id:subject
         :to:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:list-subscribe:list-unsubscribe;
        bh=sPFPP6wKqWUTn+63qFfGjxHn+5lG2lDmzhqnv4/GhWE=;
        b=qg7D9vXK7z9r9veY44UJs+7X0HyiFUnx+RbGoU6sQljrAw/XvvjfXYyISxIJw7uRSC
         6tXnZg4MJrE8UdMtsw5BGuS0Qy0siWfITBnCBGBrKzC78JfmNKybhALX5WmoPwxCBD8V
         qJ3fVplcDLfTc0cHFrEVV5jngUpB9WFx/aVzHROiqUXAfT6GraDBVeRdufDgFi/4+Jgx
         qrr2BqSNbVarBz67gMktWr8fC0wPov0bAcvDDs+bq0lH+NNPkEdinq58Xd14KMPNrWNn
         PDGN09DmUOp5z4+eYWo9aeSJc+W0BC101uUMoOZboJSjHwBwPBaQonKPaiecfswSEzMN
         17HA==
Sender: email14@webtotalsolutions.com
X-Gm-Message-State: AOAM533V2/21GlC+jRTJqzsyp5PkZjW5Oqg4bO5V94U/gwqpLujmANjV
	TQnj0f/QzjFG2dh0XWQJY6JcZw==
X-Google-Smtp-Source: ABdhPJzHR9PvbS6Pb2Cig0HIqcHlCgFldl4DJwrv1Pct9dPv6MyJfJpXXjd7Ptg4wfMeNxDZ23n22Q==
X-Received: by 2002:a65:53ca:: with SMTP id z10mr5772948pgr.271.1614403642556;
        Fri, 26 Feb 2021 21:27:22 -0800 (PST)
X-BeenThere: email14@webtotalsolutions.com
Received: by 2002:a62:1490:: with SMTP id 138ls4800515pfu.7.gmail; Fri, 26 Feb
 2021 21:16:54 -0800 (PST)
X-Received: by 2002:aa7:80c6:0:b029:1b6:92ae:a199 with SMTP id a6-20020aa780c60000b02901b692aea199mr6378492pfn.71.1614403014567;
        Fri, 26 Feb 2021 21:16:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1614403014; cv=none;
        d=google.com; s=arc-20160816;
        b=SVhuEXePTluDli2y6TRrjsU82WSRJUEcDEn7WmMTvUxNOzFiryNJgNnrJt4rnluBpu
         HOKiUWLi30h4gOYS+o77J1H7oNIql/gtBObRmne5RWlGQ37551DP/4ypdX/1xhLt09Qs
         r8TyeXHZq19v2W61onk8Gyi/0Xe/gSVdEBjlLUVh8iuT5CQgLsSsHvvnXEofmzViam7Y
         qP3YvWfzVDO47XHVSxYtKmFBFteL11wCmUUJLx2CAwZbF4WrA+QEHfkYeKgIOOn29T4k
         ZdJOU8AY0VY0RPpuItwQRY4rksjDPdtuxicMQ8jP+a4Q12qRwSaeqaaPdwMX8zpOi/ra
         hOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sPFPP6wKqWUTn+63qFfGjxHn+5lG2lDmzhqnv4/GhWE=;
        b=fKPbvtN/Cxyh/MM372fX3BczB4XCz4SygceV8vQelFq28LHaT94EGwuGv1txHKoXnT
         Mp8hgWrUOMsa7Nw+Ya29iZYVhO3RaHHtygFeGtRp4/ybiHPJbHpgJ0Qi+DmdcCypyWRD
         DzALb4ZHRtnXaFAGhFMVPjdYDA8/1piDVfWqddHqgNf/TAm3hx8rbayg6op1/utvzJjv
         2hVA5c8K2FlOKiTvYtMb9eokJQuoxkTYaywc5sZdnHVGT/dvkETPktVFFYTI09nmQeiW
         PDTkIAjFmD1J47+R+gh+izqIWM7mCl8msX78ywx8hf54vZK9vAOS5FZaniL0VzbgdN3y
         37ag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qQza03E7;
       spf=pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com. [209.85.220.41])
        by mx.google.com with SMTPS id y15sor6170956pjy.24.2021.02.26.21.16.54
        for <email14@webtotalsolutions.com>
        (Google Transport Security);
        Fri, 26 Feb 2021 21:16:54 -0800 (PST)
Received-SPF: pass (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as permitted sender) client-ip=209.85.220.41;
X-Received: by 2002:a17:90b:e83:: with SMTP id fv3mr4599232pjb.179.1614403014354;
 Fri, 26 Feb 2021 21:16:54 -0800 (PST)
MIME-Version: 1.0
From: Annu Taneja <lissajohnson759@gmail.com>
Date: Sat, 27 Feb 2021 10:46:46 +0530
Message-ID: <CAPhvtKz9dVu2LB16n8LMiPBRBzAf6LAffMTfS4wsU80Z1kYwWQ@mail.gmail.com>
Subject: On-Page & Off-Page Optimization...!!!
To: undisclosed-recipients:;
X-Original-Sender: lissajohnson759@gmail.com
X-Original-Authentication-Results: mx.google.com;       dkim=pass
 header.i=@gmail.com header.s=20161025 header.b=qQza03E7;       spf=pass
 (google.com: domain of lissajohnson759@gmail.com designates 209.85.220.41 as
 permitted sender) smtp.mailfrom=lissajohnson759@gmail.com;       dmarc=pass
 (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list email14@webtotalsolutions.com; contact email14+owners@webtotalsolutions.com
X-Spam-Checked-In-Group: email14@webtotalsolutions.com
X-Google-Group-Id: 1036746787170
Message-ID-Hash: XRZELA53EGM6SDGWTJCVATV3RPX6JVIW
X-Message-ID-Hash: XRZELA53EGM6SDGWTJCVATV3RPX6JVIW
X-MailFrom: email14+bncBCSY3NP4XYFBBR5L46AQMGQEXTTJABQ@webtotalsolutions.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XRZELA53EGM6SDGWTJCVATV3RPX6JVIW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

KkhpIERlYXIsKg0KDQoNCg0KSG9wZSBUaGlzIEZpbmRzIFlvdSBXZWxsISENCg0KDQoNCkFyZSBZ
b3UgTG9va2luZyBGb3IgU0VPIFNlcnZpY2VzIFRvIEltcHJvdmUgWW91ciBCdXNpbmVzcyBSYW5r
aW5nPw0KDQoNCg0KV2UgaGF2ZSBhIHRlYW0gb2YgMjAwIHByb2Zlc3Npb25hbHMgdGhhdCBwcm92
aWRlIFNFTyBzZXJ2aWNlcyBwcm92ZW4gdG8NCmltcHJvdmUgeW91ciB3ZWJzaXRlIHJhbmtpbmcg
aW4gR29vZ2xlLCBZYWhvbyBhbmQgQmluZy4gSWYgeW91IHdvdWxkIGxpa2UNCnRvIHNlZSBndWFy
YW50ZWVkIGltcHJvdmVtZW50IGluIHlvdXIgYnVzaW5lc3MgcmFua2luZywgdHJhZmZpYyBhbmQN
CnZpc2l0b3JzIHRocm91Z2ggc2VhcmNoIGVuZ2luZXMgdGhlbiBoYXZlIGEgbG9vayB0aHJvdWdo
IG91ciBzZXJ2aWNlcy4NCg0KDQoNClJlcGx5IHRvIFRoaXMgRW1haWwgYW5kIFdlIFdpbGwgQmUg
UHJvdmlkZWQgWW91IHdpdGggYSBUaW1lbGluZSBmb3IgYQ0KR3VhcmFudGVlZCBQYWdlIDEgUmFu
a2luZyBvbiBHb29nbGUhDQoNCg0KDQoqQWxsIG9mIE91ciBTZXJ2aWNlcyBBcmUgU3RyaWN0bHkg
V2hpdGUgSGF0IGFuZCBJbmNsdWRlOi0qDQoNCg0KDQpDdXJyZW50IFdlYnNpdGUgU0VPIEFuYWx5
c2lzIFJlcG9ydA0KDQpLZXl3b3JkIFJlc2VhcmNoIGFuZCBTZWxlY3Rpb24NCg0KTG9jYWwgU2Vh
cmNoIE9wdGltaXphdGlvbg0KDQpNYW51YWxseSBMaW5rcyBDcmVhdGlvbiB0byBJbmNyZWFzZSBC
YWNrbGlua3MgLyBRdWFsaXR5IExpbmsgQnVpbGRpbmcNClNlcnZpY2VzLg0KDQpNZXRhLVRhZyBD
cmVhdGlvbiBhbmQgVXBkYXRlDQoNCk9mZi1QYWdlIEFjdGl2aXRpZXMgTGlrZSAoQm9va21hcmtp
bmcsIENvbnRlbnQgV3JpdGluZyAmIFByb21vdGlvbiwgYW5kDQpCbG9nIENvbW1lbnRpbmcgZXRj
KQ0KDQpPbi1QYWdlIE9wdGltaXphdGlvbiBMaWtlIChUaXRsZSwgS2V5d29yZHMsIERlc2NyaXB0
aW9uLCBYTUwgRmlsZXMgQ3JlYXRpb24NCmV0YykNCg0KU01PIEFjdGl2aXRpZXMgTGlrZSAoRmFj
ZWJvb2sgbGlraW5nLCBUd2l0dGVyIGxpa2luZywgTGlua2VkSW4gbGlraW5nLA0KUGludGVyZXN0
IGxpa2luZyBldGMpDQoNCg0KDQpJZiBZb3XigJlyZSBJbnRlcmVzdGVkLCByZXNwb25kIHRvIHRo
aXMgZW1haWwgYW5kIEnigJlsbCBiZSBoYXBweSB0byBnbyBpbnRvDQptb3JlIGRldGFpbCBhYm91
dCBvdXIgbWV0aG9kb2xvZ3kgYW5kIHByb3ZpZGUgeW91IHdpdGggYSBmcmVlIGFuYWx5c2lzIG9m
DQp5b3VyIGNvbXBhbnnigJlzIG5lZWRzLg0KDQoNCg0KSSBsb29rIGZvcndhcmQgdG8gaGVhcmlu
ZyBiYWNrLg0KDQoNCg0KKktpbmQgUmVnYXJkcywqDQoNCipBbm51Kg0KDQoNCipPbmxpbmUgTWFy
a2V0aW5nIENvbnN1bHRhbnQqDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
