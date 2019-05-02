Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E583912289
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 21:18:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 22361212449E4;
	Thu,  2 May 2019 12:18:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3BFF221243BDE
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 12:18:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l25so3120696eda.9
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 12:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/EtrDUZnPlRu7IrcyamY8IpVJksLUEb2L4C6Vl0TUQE=;
 b=oY66xYN+gJbH6VpzA77vhKfQaiig9FE2gWSvaganWGQHxbnAWNBjdK5IxmHDl/lulB
 6W2/Xu6OkEtP8EzI5IoyuCT9YBGVw5tvyjPDFWBkUqfZQpnYmkvUeHHSR6HD9M3whi9I
 0RcBrH0LDorwvHBC018lfCEvaAiT8BwChZuwyw0bGNQ8t6reNn9yI72NAJTHpjLRUJlg
 LCM39zL0LwzvspTxYRli24Jer9qJRz+CVCjC6684O6EDMB0WaaYj3PyULoK2HTbRkXDi
 ghyRy0ZVgVkbC6WyahwWy/PSLoe00mm05d6lyrce//A9Vuv45sVK7mWoQ+xalrdJVd8R
 AILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/EtrDUZnPlRu7IrcyamY8IpVJksLUEb2L4C6Vl0TUQE=;
 b=M7/Q+h2aeVQBUR3x60kTF5VMlCaOHaXSQe7VZQBB7B7dnnCMwhN7aOup5j/lssvbDt
 xMoErVG4hENbd4JPZPFE1Ikhh9lSbf+uXbuRputvC7ZdyX5AuXQzCWJzjrZDl1VLNJnt
 pipa2rYWKk8BVNfbnzlr9V/pWXYb+y9/gbrY07ZthYimTHswRkcOWvT2YIfWSvIfg6F7
 ToWDCckV0796XE97xlU0+szPM8uXQDvyGKTPiJ0WBK2bjLX+O6/K+k01AhtweKR+lbRL
 erbAC4CdAiS2iMMTHLcZPjqqeuYP3W4eL1/yXoyHHEgtyGrWpiiwuB+vP+EEs3vacNal
 w++w==
X-Gm-Message-State: APjAAAWqWhaeHQEUv2wsstl4VGHuTMhZxML8Zme0Thy9MLicLhP82iDu
 rKQs/OS1BP4bnb7aAhPHwzwJjKsz2XJv/JJW37kAoA==
X-Google-Smtp-Source: APXvYqzLcGp30q9Ib2/zU1la10GlqsQhJRi/epzUUZiwaqPYnOeJoISItPcXmhWHqTVl0n32Bm0pjTtLjkVqAOIx8xo=
X-Received: by 2002:a50:fb19:: with SMTP id d25mr3732372edq.61.1556824727400; 
 Thu, 02 May 2019 12:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552635609.2015392.6246305135559796835.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 May 2019 15:18:36 -0400
Message-ID: <CA+CK2bD2b5XZCxGXQ47XXRA2RFvc69u2LKx7pu4Mtvw_ezMDLg@mail.gmail.com>
Subject: Re: [PATCH v6 04/12] mm/hotplug: Prepare shrink_{zone, pgdat}_span
 for sub-section removal
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
 linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Sub-section hotplug support reduces the unit of operation of hotplug
> from section-sized-units (PAGES_PER_SECTION) to sub-section-sized units
> (PAGES_PER_SUBSECTION). Teach shrink_{zone,pgdat}_span() to consider
> PAGES_PER_SUBSECTION boundaries as the points where pfn_valid(), not
> valid_section(), can toggle.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |    2 ++
>  mm/memory_hotplug.c    |   16 ++++++++--------
>  2 files changed, 10 insertions(+), 8 deletions(-)

given removing all unused "*ms"

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
