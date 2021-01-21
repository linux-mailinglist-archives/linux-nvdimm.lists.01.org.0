Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6192FF635
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 21:44:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AC13E100F2252;
	Thu, 21 Jan 2021 12:44:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=hannes@cmpxchg.org; receiver=<UNKNOWN> 
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E71B4100F2251
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:44:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e17so2603228qto.3
        for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJ5PGzGmiLLUrzTi1u+PWslzt/cE4FGIGC3QTg4GyNU=;
        b=XEexdU25vzlHX3yTNVNzHMDCFhMAUHi0vHqq4srg310OpkDzUMqIMQosp76W9eriKq
         K9WdGHf0i2fo+5ydgoMD1zCkBRDxshw/C96HIx0vh+MJqsiXANwLVeIuvxdCC2kGGRbh
         LCUle2LeLtQzg/wP3aqbFAjL+rGOZ5XSjZPMhEJg7THs81mGHvzOAnUTwaDnOoGvKUfD
         S8SxZwBjwPxb6qcZN5TVWQwm3zeRVRyq/Z6mYQSWvIwUdgGaPrLhNKZAE4+RXiX27EZV
         AaPhYYUB23m+NhNaDvZc3ioHaW7WlGjKCjapKaKC8H5kAGk5+RS3+oW1ZhG+1+Irihyi
         M+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mJ5PGzGmiLLUrzTi1u+PWslzt/cE4FGIGC3QTg4GyNU=;
        b=ggcx95tm6D5YqjLE9E7BhGZp5oPPqU99LLdzV9QJtWKKjjesb855HBcb04l+ul9KGk
         5PS4vhHomOgwgas5NyxcC9nLnpTnnp3xsxUBHEkuEro7+P0WIlruooI4rW4jyPpiq7iV
         faT52gdDjKhEi6m4e+WtFdrsVibKrmoKL8XsFOPoB/9Eh4LdIWvLXphKSIoujh0a1drq
         +zfpGB9oU0QqZUQ+yvToTHdjZQK3p6SbgOp2Mipt9gy95TMQHS2SMm/CTsgHib1yeGKb
         jaVVePcrPMbMYBSc/p5nbBfj72W+FLGiSx4qbRzVT/SI6Ok8pv7grc2EfdFhDwBhJVAB
         3Ohw==
X-Gm-Message-State: AOAM530rfYD94gyGcz25FfvwQh8qIck9WWc2F3U6YrGFI0AjCHyQXJQp
	zWwm5IxzTrNHKVk4225u5uSHgQ==
X-Google-Smtp-Source: ABdhPJzJp8jl31mPFjPI2gRRVkFEDO5aKL9LMCYtxQ+I4Cn4WNfvBbp1XuW8P/En/rtFBsqUQr0fig==
X-Received: by 2002:ac8:7b42:: with SMTP id m2mr1435255qtu.304.1611261861619;
        Thu, 21 Jan 2021 12:44:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id i27sm4610509qkk.15.2021.01.21.12.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:44:20 -0800 (PST)
Date: Thu, 21 Jan 2021 15:44:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 2/4] mm: Stop accounting shadow entries
Message-ID: <YAnnoydGwtXwPMHL@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-3-willy@infradead.org>
Message-ID-Hash: HQPL6ZQUAG3ZFYFS2HBI76OV34L6ZVYZ
X-Message-ID-Hash: HQPL6ZQUAG3ZFYFS2HBI76OV34L6ZVYZ
X-MailFrom: hannes@cmpxchg.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HQPL6ZQUAG3ZFYFS2HBI76OV34L6ZVYZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 26, 2020 at 03:18:47PM +0000, Matthew Wilcox (Oracle) wrote:
> We no longer need to keep track of how many shadow entries are
> present in a mapping.  This saves a few writes to the inode and
> memory barriers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
