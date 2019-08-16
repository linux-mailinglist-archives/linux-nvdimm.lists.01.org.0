Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC490A73
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Aug 2019 23:48:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C9D2D202E8427;
	Fri, 16 Aug 2019 14:50:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A2112021EBE8
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:50:11 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id m24so10832052otp.12
 for <linux-nvdimm@lists.01.org>; Fri, 16 Aug 2019 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LyElFB/DQKr6Gizru8u06ztJ06NwMdbnhXlNaM4nxfY=;
 b=mrS+amgv8MUZtXXjJgioy8ife407MwfpV3HzSJJM97stHaySnNcwdMkTrTmdO42TYK
 mUXUzfAuYL56dOpVKrZt05dICfv+fI8pIKUkLoB5gQS7fIMA6VnmaZtqpu9yzur2D52u
 LBrXk8ygWWjZ4FpncAY6ObVGddD32Crqr5bzzOhGaPJ93LP4y7Z4pFxkMRd6W/qhzGfa
 PVa4MQVGxMg4/5XN3/SAYycOiedKl5K2505hnWWZdBfrl4KYNov4c0Gpp35IRPTqtVMZ
 vK/09rXwd8ggXEKI8s7m22aN7Zk8QYG7+wbSQ7oyz0uPAgtAeOWiv4nUyaMJzO4hBrPb
 czfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LyElFB/DQKr6Gizru8u06ztJ06NwMdbnhXlNaM4nxfY=;
 b=ZLLQnRrqmhcl+Hn+TppTWSHK/FbSqhXXA2q8vJsIojOIzMzMNd4husPE2DCgWiDgqg
 0tmeOJQGTUng9tqv6/kPxomJmb+NAdkqBg9BnbXXJOWQqyWroEw9HKM1JJK/eUmtRWbh
 kSJkWJc9NucM9ldENIFACJN54IElbFW/5Ywi31/brQ63c1C8mMrL72myg4WfAfoYeK92
 KAjLSc7JkqXkA8mWZB9A2IUahiAqdeuTp60EDhhVkDVmnArN+uTwRBkIf0lyGtu42q1H
 sCRMPTsjsMF/9m5XB00DRDhQPuI+gETMiddWrobgNirZM2gUoLPbujKCRF3g8heYWAV3
 9pHA==
X-Gm-Message-State: APjAAAUzV65/pHqshzq1mq+1xLkb12/YXDtc8e/FsLhgWz8jMUc94AP+
 Zx88ULTYe7BiVhytZEmKOyu1mFLZhDLHZv5FmDFd2Q==
X-Google-Smtp-Source: APXvYqyDpwbVXFlvMymCKEQxblapyLZJ2uTf8kCcMCHUlKmdPHMPy2wDX6J/Yo2/rZ+OzbU3y2tiV4thup6lKoyweVk=
X-Received: by 2002:a05:6830:1e05:: with SMTP id
 s5mr8439514otr.247.1565992103975; 
 Fri, 16 Aug 2019 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565991345.8572.28.camel@lca.pw>
In-Reply-To: <1565991345.8572.28.camel@lca.pw>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Aug 2019 14:48:11 -0700
Message-ID: <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
To: Qian Cai <cai@lca.pw>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Linux MM <linux-mm@kvack.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev@googlegroups.com, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 16, 2019 at 2:36 PM Qian Cai <cai@lca.pw> wrote:
>
> Every so often recently, booting Intel CPU server on linux-next triggers this
> warning. Trying to figure out if  the commit 7cc7867fb061
> ("mm/devm_memremap_pages: enable sub-section remap") is the culprit here.
>
> # ./scripts/faddr2line vmlinux devm_memremap_pages+0x894/0xc70
> devm_memremap_pages+0x894/0xc70:
> devm_memremap_pages at mm/memremap.c:307

Previously the forced section alignment in devm_memremap_pages() would
cause the implementation to never violate the KASAN_SHADOW_SCALE_SIZE
(12K on x86) constraint.

Can you provide a dump of /proc/iomem? I'm curious what resource is
triggering such a small alignment granularity.

Is it truly only linux-next or does latest mainline have this issue as well?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
