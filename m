Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A8333035
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Mar 2021 21:47:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2B8F100EB856;
	Tue,  9 Mar 2021 12:47:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2DA9100EB855
	for <linux-nvdimm@lists.01.org>; Tue,  9 Mar 2021 12:47:04 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jt13so31640696ejb.0
        for <linux-nvdimm@lists.01.org>; Tue, 09 Mar 2021 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=cnHrmQr/VMb/t2E/EgCby5Ir+NbwqGQ0u5beELJg+31cT1IgztSHwumMnd5zdcoDB2
         66n4NERbQg+uvwjesYYTCrNMtq9i9BOp/xxNWs/vGHWpji0JOhm5y/MI1V1Ox4Pc4WRW
         tBCkqmAvU9bVb4X02t4bXL1znuI21REF0jrmhFii+VAU1w787tzlvvkSi8J6MFfQp9Qc
         pDQjCC5HheYIdn0dNKCnxnEBuaRZu7xTQPpa9IDV/OMAz50a7gzVrpOYTiwkLGnkyiNv
         Xl9tJ2GvH5S31+9GqAUexpRyDEuTmNjlBu3J2Ogs0+mgYdfyBUBeIAD+tjEcWDtq2eIa
         u1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxekq9CmjmqiQezEq23fxoA2lWRbGVUv5ZHopeMn1UE=;
        b=jkaG9xbQN4aRUbRBTScU7GLGLhQLOrNT05eZV+2yPXYM5pfgGRtTtxnpD7DzkBHBds
         wn5IZ7kMOTdf3Kai9DXZhP0KbTu7gvD8XVNFwo3adVk0dkl6TEpQ+RYmSKEnSAnKyR8z
         uy0EXLbTsxVpBFluuQgdX4kGUElaWkA+px30ZK5vcEPe44DUpotghsfzSL3R4JoqocnF
         zYM87gdU04MPZHNwR1x7tYs/FVmtOFlljhlmecY0Rn2bM+wjR9V0Z0n0eVZDGBzVSQEB
         Yed9cAKUvJ8xSALjxZfc2dGAn5yhSqc6/5G8f1z8yD1yjodVNUFLn7IjTgCRnCuJAuHQ
         DHeA==
X-Gm-Message-State: AOAM533aOhXPFwioHHtfGz6ZQZVq/K+yPfDUQ18FeVFPGnkQ4DMruG7U
	/Cw5mKhkJDRtG/acG3/qxJbI8o2RzWoVAoW86xmPlw==
X-Google-Smtp-Source: ABdhPJyGCNUbmQJ/wDHu5IcJL/niMgxwiRhAm5hQcCcYAEaJxVRh4Cge+6PJtQJj3bcb2aVMkwUuE9suuO9SNZofuRY=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr22581663ejz.341.1615322822643;
 Tue, 09 Mar 2021 12:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20210309195747.283796-1-willy@infradead.org>
In-Reply-To: <20210309195747.283796-1-willy@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 9 Mar 2021 12:47:00 -0800
Message-ID: <CAPcyv4iQ8qfyhungkhdDKqmOUrd0e3XtExxC_2yz+zX8ncBsrA@mail.gmail.com>
Subject: Re: [PATCH v2] include: Remove pagemap.h from blkdev.h
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID-Hash: ERNKAWA4PSYIQQTIX26K6UFCWRFFF636
X-Message-ID-Hash: ERNKAWA4PSYIQQTIX26K6UFCWRFFF636
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Linux MM <linux-mm@kvack.org>, linux-block@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bcache@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-scsi <linux-scsi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ERNKAWA4PSYIQQTIX26K6UFCWRFFF636/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Mar 9, 2021 at 11:59 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> My UEK-derived config has 1030 files depending on pagemap.h before
> this change.  Afterwards, just 326 files need to be rebuilt when I
> touch pagemap.h.  I think blkdev.h is probably included too widely,
> but untangling that dependency is harder and this solves my problem.
> x86 allmodconfig builds, but there may be implicit include problems
> on other architectures.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
> v2: Fix CONFIG_SWAP=n implicit use of pagemap.h by swap.h.  Increases
>     the number of files from 240, but that's still a big win -- 68%
>     reduction instead of 77%.
>
[..]
>  drivers/nvdimm/btt.c      | 1 +
>  drivers/nvdimm/pmem.c     | 1 +

For the nvdimm bits:

Acked-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
