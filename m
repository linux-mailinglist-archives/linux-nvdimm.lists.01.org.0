Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A71228F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 21:28:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20CD8212449E9;
	Thu,  2 May 2019 12:28:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D2048212449E0
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 12:28:33 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w33so825610edb.10
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2BtVF69qKBrz9RiY6v2/KzAanhM7UTkuvfK1eqLRPts=;
 b=anlXyzLHl7/mu36RIFAIxcKsrMSkce8RmXLT6gA8XWonyrduEZz1Kg+UsC5D7z8FMT
 pj/5pMF5ClMHohgj3ZkruEIp4c2E5vQjyL591Z6YSXLnoKPyWVamFD6tN0pTpi2Xf+h/
 6EzBRSlftPpfc3PWdfVmuQ20DUG8J6I1uPHl0PHVXqEYgJSmeLguWSTy+gizwQEVh6D4
 zU9Rll/WLv1aAxKOG1/NLVtaNEEZD0tv0yxKuRd4XH5bskMKWYH80Kho+m1Dm+hRb0yt
 zHtzKyeb1W4lTDOJ3OHpU0hw3N/Lnedq8p2bBwEGvzkeS6cCOEC/t+VkwYNJtyLd9K+K
 BM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2BtVF69qKBrz9RiY6v2/KzAanhM7UTkuvfK1eqLRPts=;
 b=e+EC9uaJZfVB9e9/yE5nLq6PBsquhKM0nqwOBiKtW9Y4TVFU5zox1CLGR4C0BfHQGI
 NztVY0besSmp+NiZiBmXCTeSZdzF834+iLXIrHIiT9VTZZeJgIiOevHUR3ep4n8QUWIA
 oXtn2WvYmXMW9JqnxeWZL2AWa1M32LNR4V4xJU9MqfcGm4qdrDG4aK9uEalZjVuK4S//
 9eBntR1zFPp2sXplRcNbKAfy8VduNTIEwJV6lTGigkcuaOfiszCJq9PxprvQtFL7CNWV
 0UWSf7CFU5bOCCAfm+0BzuaCU0lWDIZjJZzIhEcmHn1J9mpOlg5UudOz2iQAhjy1LAly
 ePsg==
X-Gm-Message-State: APjAAAVtTrCnAwnQcKGnX7ZCSz2DLP7D75wQNUEp+MDdpNb7VZ0EZ5/M
 +I8871A60BXgGl9ZlmOms2em1A2QCG/dkO8YMub45Q==
X-Google-Smtp-Source: APXvYqzhKsKRt3YYywySk19JgdcvKgG4zttzP8aHLHqRlNIg61SzvLJCSfVQUqqi+2uhnhEboRWyoEvmzKYQf/GF1Ns=
X-Received: by 2002:a50:b4f7:: with SMTP id x52mr2879275edd.190.1556825312425; 
 Thu, 02 May 2019 12:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552636181.2015392.6062894291885124658.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552636181.2015392.6062894291885124658.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 15:28:21 -0400
Message-ID: <CA+CK2bAfw=pkYF2Ux-PM5r7U46JbDA-fM3NjQ3a5F_Fs0D0GHA@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] mm/sparsemem: Convert kmalloc_section_memmap()
 to populate_section_memmap()
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 David Hildenbrand <david@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Allow sub-section sized ranges to be added to the memmap.
> populate_section_memmap() takes an explict pfn range rather than
> assuming a full section, and those parameters are plumbed all the way
> through to vmmemap_populate(). There should be no sub-section usage in
> current deployments. New warnings are added to clarify which memmap
> allocation paths are sub-section capable.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

 Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
