Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D68522645
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 May 2019 09:48:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AF4B21243BD4;
	Sun, 19 May 2019 00:48:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ericdotren@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A6C742122C317
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 00:48:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 145so5271960pgg.9
 for <linux-nvdimm@lists.01.org>; Sun, 19 May 2019 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/j3k1Uwzq/p5ELQeTWgPQPAffivKnJ2PtzlIBXWBM6c=;
 b=K5R/DyCUrHt8cIAdX4Xnvh++kdyjT11135KWSw3FFh/E0Gj88G+blscvovwNjsc255
 w3aV35daaxm5KWHlVyDn51IbSCrTEfJ/IAnMWzm5vSV4gyhSYh6U9pTDyQ6IsK8FSRqD
 E0CC6npyH/4mJl+B0VTqAeCI8md8FgCSBw8ziH6gB1JT0pehRXOyxsqgLwlvDzun63b0
 EUFYWSvJSLjFVZjDVYOOdFP2847wW7Kp72ydNNkcIfxgSVLLCWXSBDobEMZ+ki2l4dDu
 5ZBSqdAkEzvoDJVLCLPNGfuLPmDMjIKMlcQ52Q935XPACowZS7pGIP1hUR7yw6FnaB+A
 k6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/j3k1Uwzq/p5ELQeTWgPQPAffivKnJ2PtzlIBXWBM6c=;
 b=RsF/JZr+Mdja/teeRPre86hFtpxeAQQlAN3ysC9hShzKOG7lRNhaZvIcFuSnpK5MQe
 PIgGXDhRE/3i8bzcthUVDcNz7gBJXnkSTteLDQLJMOg/HVlztDXg9IDDVxv0K3kedg9c
 8wzg2fcUuLmFATvpA4/lIoj/S/NG3IlJaQBS/g4jAB/k5dyDXw4yHlBIT2cMdEaCfyIP
 ehOlAQTalQRk/1zUNgw+JjowX1aft88eEQnydN4KPY8SzVwAysfbbIf+gWocPB2wDo74
 7IQfK9L6LjyZMaCJFjKdBTK54CYoN7Za63AXrPjOPGi3+eAkTSW+UVMfUrM/C+dcu+KE
 0dCw==
X-Gm-Message-State: APjAAAXfI8+TWxTQ6MjSUwkW0dkE0ksTROfr4ogp6ouOBzhX2INkwaKu
 FGhzMSUOYdjI98hilb5wAGkv4h4+EUbcvJh4mgrJrTQaztE=
X-Google-Smtp-Source: APXvYqwVQvEpXX5bp4fxP+LBJajbYpkN/gxmYLOlu19j+za6+xY8aPOPCT5fywsCo46+Z9l31gAwXd6Ix9IdF9XH+4I=
X-Received: by 2002:a62:1844:: with SMTP id 65mr60737508pfy.127.1558252096790; 
 Sun, 19 May 2019 00:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-27-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-27-vgoyal@redhat.com>
From: Eric Ren <ericdotren@gmail.com>
Date: Sun, 19 May 2019 15:48:05 +0800
Message-ID: <CAN+Pk99SNKSf+GjSQUUWt_eu1fSjTy_ByUOEQUXHi8zNqXY1zA@mail.gmail.com>
Subject: Re: [PATCH v2 26/30] fuse: Add logic to free up a memory range
To: Vivek Goyal <vgoyal@redhat.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: kvm@vger.kernel.org, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi,

@@ -1784,8 +1822,23 @@ static int fuse_iomap_begin(struct inode *inode,
> loff_t pos, loff_t length,
>                 if (pos >= i_size_read(inode))
>                         goto iomap_hole;
>
> -               alloc_dmap = alloc_dax_mapping(fc);
> -               if (!alloc_dmap)
> +               /* Can't do reclaim in fault path yet due to lock ordering.
> +                * Read path takes shared inode lock and that's not
> sufficient
> +                * for inline range reclaim. Caller needs to drop lock,
> wait
> +                * and retry.
> +                */
> +               if (flags & IOMAP_FAULT || !(flags & IOMAP_WRITE)) {
> +                       alloc_dmap = alloc_dax_mapping(fc);
> +                       if (!alloc_dmap)
> +                               return -ENOSPC;
> +               } else {
> +                       alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
>

alloc_dmap could be NULL as follows:

alloc_dax_mapping_reclaim
   -->fuse_dax_reclaim_first_mapping
             -->fuse_dax_reclaim_first_mapping_locked
                  --> fuse_dax_interval_tree_iter_first  ==> return NULL
and

IS_ERR(NULL) is false, so we may miss that error case.

> +                       if (IS_ERR(alloc_dmap))
> +                               return PTR_ERR(alloc_dmap);
> +               }


Regards,
Eric
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
