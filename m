Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B323695F5
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Apr 2021 17:20:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C2CE4100EAAEE;
	Fri, 23 Apr 2021 08:20:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com; envelope-from=damesalle132@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7921B100EAAEE
	for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 08:19:58 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso23109077otl.0
        for <linux-nvdimm@lists.01.org>; Fri, 23 Apr 2021 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IeyU6ogacHzhKikUzm5Y/puaLChm3iyHuJBsQWkBdfI=;
        b=QLjgCZto1H/lUj/C2pmIWyLDxj79nvFmJ41BqX9X5R5igBNqhwGggG8Eau4gL16eN2
         7xgSQ2z7nP8+Wa0p42BFxTFV55m4PbRvn64ccDUTq0ZhPxVZbO7nnURO3Jj0btM8obq4
         HK/exBk7hkHB3sS8bwyt0WaZXb2bPmvAeJ2+gnJjV1mr2DD0/AQ2K4m8FOxk8VedHFo5
         Ht2VL+uajjEt8PEOAvUzvZWOh84xLtdlELn0LAjJlLb7ab7uBsN+nDWJxZf4/7VyV2oe
         0C4htC1h+cj+0sx9grz2/XroX667BNmtF49mbMl826oyroT9j6n7n/oVC6vqyoA1hA5J
         NPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IeyU6ogacHzhKikUzm5Y/puaLChm3iyHuJBsQWkBdfI=;
        b=BgcYDFZ65o0PZzDC/nri7hgE/5eSE8nmukEt2aoH9wXYBmCW9jyIV+L4ldN8EK/kjG
         UHWaXEErMylssnw4D3bHeaZq3IP1VuF6hIu8zxftLiXqhXAr9p5aDX8teKiG27xA89q0
         iTDKqLpNwmhfIxS8Euta9oEQKjfV4Ultx3AIuhRda0F2ShHjsdOhmT5Oj4nbRCldaTwJ
         WgBjAbVAJ64LcpFVcVuKapO9xwkIpAF08Ac6UdwjfZgaFJDwbj5yEUuJxsfc0I+EgiLi
         nwczNqxwxOIocPxG53AJKicBy8LvW6qUexlOqpkyqrwYB5EV9fJY54J2mQvxMiRV8mnN
         hL8A==
X-Gm-Message-State: AOAM530Ln4P7mBdXwSuZWLOOZXV+kvxWVdpocMp8C/F0ilZeNmBmnsE2
	n1akIK7FB3U+9cwYgGsVdm3XyhetXUrke8A3m9E=
X-Google-Smtp-Source: ABdhPJwlsvsaaslIWKXCuCaw8Su9gYG1n/JQVZGuIkb5r2GlnCIJHDmPGQOnkGBYT3hR0N8kXjvE+M68WZ3s7JXfD04=
X-Received: by 2002:a9d:d05:: with SMTP id 5mr3916087oti.312.1619191197748;
 Fri, 23 Apr 2021 08:19:57 -0700 (PDT)
MIME-Version: 1.0
From: Karen J Brown <karen.j.brown211@gmail.com>
Date: Fri, 23 Apr 2021 15:19:43 +0000
Message-ID: <CAFLzmNvqMJ__1dfGK03QoX63Skb07ipTVT93AU3adSEOGmc_7w@mail.gmail.com>
Subject: 
To: undisclosed-recipients:;
Message-ID-Hash: TZD2G5J5Y7JSVEWV6JOJZI5TBQCW4BRO
X-Message-ID-Hash: TZD2G5J5Y7JSVEWV6JOJZI5TBQCW4BRO
X-MailFrom: damesalle132@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TZD2G5J5Y7JSVEWV6JOJZI5TBQCW4BRO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 Can we talk please ???
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
