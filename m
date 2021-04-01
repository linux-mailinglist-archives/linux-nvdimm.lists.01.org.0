Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1D350FE6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 09:12:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E18A100F2250;
	Thu,  1 Apr 2021 00:12:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=ritesh.list@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5097D100F2248
	for <linux-nvdimm@lists.01.org>; Thu,  1 Apr 2021 00:12:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ay2so565487plb.3
        for <linux-nvdimm@lists.01.org>; Thu, 01 Apr 2021 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nxMNAPqfEecVrR9nsQ3IMQjDvIPPMionqLgGG/C5wWA=;
        b=aAdIzAP/zZ+sCtwAMULjg8RvFRaUxbhfDBsKNuVR/XLjizIfWzDd3hUB/KicPKPnaC
         02SG/m9gHQWaYwbykIIVmU8qS3ZSJfm+QB+hicInaV35nmphZneW5raMdoZelMgvkttF
         oainkJuCjUbTJZvnT/QBcGMX4czVcKORLF64O34qQKY1HgrcosMTkxDccPg6DMcHfres
         1wUAKSe4/3Ri9POKIIFzlUBoK+V3frEp3BNmCjuyE37qf1MTLnCc0j6/R+vhEM/06Lel
         SHcZnQkxyKsa/kFfguLzr9cVP1LeXG8Y2eTcOVZ+0STaexxY5wynMrBmA8M0GWfVCCX8
         GeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxMNAPqfEecVrR9nsQ3IMQjDvIPPMionqLgGG/C5wWA=;
        b=ttDMTz4HYXNdk+0PiP9A0MSP44suuE63+m7/H071JLHs9WdCWwrMI74cJwsmi8M1w9
         bT6f2ToORurCfFvuzVfq+kWAOphPm+CiHDE5Axj2x/GhOP2cGV7GsoNdSQ5MbQpK883d
         vDOqMXyfUhgQiCIynphsvvosb3v0HFNJiR92qtZ7nYn7Zh18KBmoqm7lPTY9T4ZQPaDQ
         UabCd4M8cgh87BVdh6RPX+V/Qngf05CGY8Qrzr8DS9rVQfQg+bk9CdMm/fMajj3dR8IQ
         pCSgG2EiOUyzHSS2JKmMKbDiJe2oPV660Gi/Ys5aU9b4HK64PidtPHTREfafkBMK3E0i
         Ry9Q==
X-Gm-Message-State: AOAM532+AuFAsyIEpKk1ZWAn0SQcfSCMTATMIhniSHA0WSdbJPNKg6Mk
	FsePoUmTn6fANKGSzmxa0y0=
X-Google-Smtp-Source: ABdhPJx54GLu44ceRw1VOt4nY0MtGnri8a1v/wQ/JC9/nOhtBatQ1/YNYXNfg6t3Zm5Ef8q/zt/jjA==
X-Received: by 2002:a17:90a:fa89:: with SMTP id cu9mr7702778pjb.204.1617261152822;
        Thu, 01 Apr 2021 00:12:32 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id v2sm4292271pjg.34.2021.04.01.00.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 00:12:32 -0700 (PDT)
Date: Thu, 1 Apr 2021 12:42:30 +0530
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v3 07/10] iomap: Introduce iomap_apply2() for operations
 on two files
Message-ID: <20210401071230.wbrawpzk3opzmntv@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-8-ruansy.fnst@fujitsu.com>
Message-ID-Hash: CEAWZPQNC7JQCGS6GOZK45D7QOERUOZZ
X-Message-ID-Hash: CEAWZPQNC7JQCGS6GOZK45D7QOERUOZZ
X-MailFrom: ritesh.list@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CEAWZPQNC7JQCGS6GOZK45D7QOERUOZZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> Some operations, such as comparing a range of data in two files under
> fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
> we introduce iomap_apply2() to accept arguments from two files and
> iomap_actor2_t for actions on two files.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/iomap/apply.c      | 56 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |  7 +++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 26ab6563181f..fbc38ce3d5b6 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -97,3 +97,59 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>
>  	return written ? written : ret;
>  }
> +
> +loff_t
> +iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
> +		loff_t length, unsigned int flags, const struct iomap_ops *ops,
> +		void *data, iomap_actor2_t actor)
> +{
> +	struct iomap smap = { .type = IOMAP_HOLE };
> +	struct iomap dmap = { .type = IOMAP_HOLE };
> +	loff_t written = 0, ret, ret2 = 0;
> +	loff_t len1 = length, len2, min_len;
> +
> +	ret = ops->iomap_begin(ino1, pos1, len1, flags, &smap, NULL);
> +	if (ret)
> +		goto out_src;

if above call fails we need not call ->iomap_end() on smap.

> +	if (WARN_ON(smap.offset > pos1)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	if (WARN_ON(smap.length == 0)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	len2 = min_t(loff_t, len1, smap.length);
> +
> +	ret = ops->iomap_begin(ino2, pos2, len2, flags, &dmap, NULL);
> +	if (ret)
> +		goto out_dest;

ditto

> +	if (WARN_ON(dmap.offset > pos2)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	if (WARN_ON(dmap.length == 0)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	min_len = min_t(loff_t, len2, dmap.length);
> +
> +	written = actor(ino1, pos1, ino2, pos2, min_len, data, &smap, &dmap);
> +
> +out_dest:
> +	if (ops->iomap_end)
> +		ret2 = ops->iomap_end(ino2, pos2, len2,
> +				      written > 0 ? written : 0, flags, &dmap);
> +out_src:
> +	if (ops->iomap_end)
> +		ret = ops->iomap_end(ino1, pos1, len1,
> +				     written > 0 ? written : 0, flags, &smap);
> +

I guess, this maynot be a problem, but I still think we should be
consistent w.r.t len argument we are passing in ->iomap_end() for both type of
iomap_apply* family of functions.
IIUC, we used to call ->iomap_end() with the length argument filled by the
filesystem from ->iomap_begin() call.

whereas above breaks that behavior. Although I don't think this is FATAL, but
still it is better to be consistent with the APIs.
Thoughts?


> +	if (ret)
> +		return written ? written : ret;
> +
> +	if (ret2)
> +		return written ? written : ret2;
> +
> +	return written;
> +}

	if (written)
		return written;

	return ret ? ret : ret2;

Is above a simpler version?

-ritesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
