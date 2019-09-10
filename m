Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF466AE528
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Sep 2019 10:10:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F34A1202BB9B1;
	Tue, 10 Sep 2019 01:11:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7A601202BB9AB
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 01:11:14 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g16so1948649otp.8
 for <linux-nvdimm@lists.01.org>; Tue, 10 Sep 2019 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QlB5C2Qiud9g32s9eqdaZLMFUYhvN4j5EbGFXFjXWus=;
 b=rPET32eIDAd4gaZHT61j86Q0xFLVBvLMT0Jg07yNPG899fgP/whW1CQ9S/zsnU8jk9
 LsPPzArWFFwSndP9G0ptTQV35ZfEX9neYY3TizcOxNujCaqDz6jLLQe1GDBiRdRh1P8R
 nVzeaY0UbYMdnWDEvoCED3sc663ICcO0ONtjvfNrN/fjCQ2Z049eL+BgqmvjXBi7bAHu
 P0U06pkgIskTnyPK51MuKONQ3wThYc73PbrsrM7QjJZ8ZnC4BEGxlLw8pA+mXsapkqdp
 o/IiVseI8sL5xRYopXqC7XSCIwNscycDqlNPLaMaIrGp71CBbbtpal419N8nKNLi8v3d
 rXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QlB5C2Qiud9g32s9eqdaZLMFUYhvN4j5EbGFXFjXWus=;
 b=rN6vOi9AW/xP7LfEcP01flc9WAM7rfK8j5eMDvX/pFfeKU1RXYQDuKFFg/WCf1rOTD
 LCk8HSwcmvCBo1aRNh4HIODXlWpiG0yRg4Dw7SgsGwV/ahAY+DFLZhfgevxx+ByHJdyU
 keSvtFVTqkvgmeW25/ysijFBzKhesuBRRa0uRVjg5+h+KmvXu1F2U4OeKv2V2IagxI7h
 mKSJuiG8grWbAPOoMjVz6accqc0SPBoNsk3Lt8z2YVR/fZPgFl7J0G2fb0b/5+MwOUDs
 bOVhr1VkF0jVbRPO+USk37APxfT4Eq6nZcMjhFmgk2fmE661+1bZEwCwDDmzFSqejO9O
 deQw==
X-Gm-Message-State: APjAAAU85iY1Pqi3UdqdYEFPVJlSAKS0Z7T2JW5+MCHR005tWDd82elt
 TkP7zqk7nFngelFND8DfS4yGJ2ZXYLdjSKXW3H4rZg==
X-Google-Smtp-Source: APXvYqy1NXK41V3Ck9QFJaZCAALhijgBMiJveNzCw1I+jdRMd2EPGEWQBUvjsFu6z+kJV2trz1531iJZT3nKGev8p4I=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr23458806otb.247.1568103053962; 
 Tue, 10 Sep 2019 01:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190910062826.10041-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 10 Sep 2019 01:10:43 -0700
Message-ID: <CAPcyv4jmO381oLTHBM80jNy6uNNkXvsOyGTjqSY4zzaS6-4_nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm/altmap: Track namespace boundaries in altmap
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 9, 2019 at 11:29 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> With PFN_MODE_PMEM namespace, the memmap area is allocated from the device
> area. Some architectures map the memmap area with large page size. On
> architectures like ppc64, 16MB page for memap mapping can map 262144 pfns.
> This maps a namespace size of 16G.
>
> When populating memmap region with 16MB page from the device area,
> make sure the allocated space is not used to map resources outside this
> namespace. Such usage of device area will prevent a namespace destroy.
>
> Add resource end pnf in altmap and use that to check if the memmap area
> allocation can map pfn outside the namespace. On ppc64 in such case we fallback
> to allocation from memory.

Shouldn't this instead be comprehended by nd_pfn_init() to increase
the reservation size so that it fits in the alignment? It may not
always be possible to fall back to allocation from memory for
extremely large pmem devices. I.e. at 64GB of memmap per 1TB of pmem
there may not be enough DRAM to store the memmap.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
