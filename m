Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656828A3A3
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 18:44:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12F5021309DDB;
	Mon, 12 Aug 2019 09:46:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A96A21309DB1
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 09:46:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r21so155320579otq.6
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yq4g4ecRC6yyVSOBidSNfdDYV3DpcZPTt6IYgshPZOs=;
 b=uHWz7Lzg7LqLmFXUBQc2JywoOVW9IVEsmh/TkjzxUM6AHyWLM+LzIuqj6recJBuUbU
 BlxxBqFXSRUx0jTdx+KNyI86wiK3Iz8az1t7zFdzRtcrb0Mfr/PXMprq0ZLs8F0DxoRN
 DkcPiw+zyhzUXUz+FtAPm/4/WyrwQXD9XD4QwGsy6LmWel4C1WhSZeDOtD68zyZLiGLq
 xZqkGOmWDL4N8a0Se2lbPo21tdJQ8nNJ4BibKjgNH4nObSnQaKEoWII2GDxM2aINo3/m
 yZPtOY+BjgG55qLTj0lywtYipSVvEZ1acBSUB3GYVeoFySuiMbGXNGuPdNyavQ/khDyj
 rAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yq4g4ecRC6yyVSOBidSNfdDYV3DpcZPTt6IYgshPZOs=;
 b=Wtq+UBBedofVbDOGWwRlW/mg3sf9oLo7RvLTS4Y54JWwyVJ9p74ZmESMvab7JZ+0zt
 F84cfGZQr+S/dsnP+M7HLuiacBWJb3K2qduLQixXl4OehwllRYp+6hKZRcOeuwvPj3dA
 khBfzkC+7a8I65OfO1ZJvDFG+fxEi05VWz1GxOioaaEkVAt4LP6Uj8cm9yb9gOSA39BL
 4gioFYgrqzFIUVaA0iOfPgvvtTrxUdodoHLSKwOZJOzg8CkDKpvxHwjzESg4WFRNKtLQ
 8fZyudSY5YtdBKNgsxeoAvFQwHPJAPH2rzLp36bpisN0SzVHb3FoPryv/WaZ/Ln95s15
 DBDQ==
X-Gm-Message-State: APjAAAXX/qkYLXXbkg2ekXFQ8wOSxmRonJF85u3AdeCy0LSXJ6G4xYNb
 4qgnx7TuIz0V8SBiuNz2ouHdNRdYeZSSIVHpgwFaJQ==
X-Google-Smtp-Source: APXvYqxIc6P5BbOlspBIEJm2S3PD4YurhGQFQZsVfY1Gaxt4ekPGBxAkn2c7Af6apTI665emPRcRSGFJ1tiXWrZdjIE=
X-Received: by 2002:a9d:5f13:: with SMTP id f19mr22476928oti.207.1565628261713; 
 Mon, 12 Aug 2019 09:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <156530042781.2068700.8733813683117819799.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49blwuidqn.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49blwuidqn.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 12 Aug 2019 09:44:10 -0700
Message-ID: <CAPcyv4jZWbBUrig3wnE+VGptMEv3fHeRJbRhmMncQwkjLUbvxg@mail.gmail.com>
Subject: Re: [PATCH] mm/memremap: Fix reuse of pgmap instances with internal
 references
To: Jeff Moyer <jmoyer@redhat.com>
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
Cc: Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 8:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Currently, attempts to shutdown and re-enable a device-dax instance
> > trigger:
>
> What does "shutdown and re-enable" translate to?  If I disable and
> re-enable a device-dax namespace, I don't see this behavior.

I was not seeing this either until I made sure I was in 'bus" device model mode.

# cat /etc/modprobe.d/daxctl.conf
blacklist dax_pmem_compat
alias nd:t7* dax_pmem

# make TESTS="daxctl-devices.sh" check -j 40 2>out

# dmesg | grep WARN.*devm
[  225.588651] WARNING: CPU: 10 PID: 9103 at mm/memremap.c:211
devm_memremap_pages+0x234/0x850
[  225.679828] WARNING: CPU: 10 PID: 9103 at mm/memremap.c:211
devm_memremap_pages+0x234/0x850
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
