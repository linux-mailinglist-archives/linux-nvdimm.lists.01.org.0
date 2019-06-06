Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34437FD4
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 23:46:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B9742128DD52;
	Thu,  6 Jun 2019 14:46:47 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=akpm@linux-foundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B4AE4212741F2
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 14:46:44 -0700 (PDT)
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 309C320673;
 Thu,  6 Jun 2019 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559857604;
 bh=e8zSxF2YstjZdXDoPM2QroSTxqWSMLpjdXaDzNM/bHM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=dfZnA3LoZI3kcekTvMdg7vm4wyUFToyxp29Scm6Cs7omCJytnHlzwlMXFqlGds2ht
 tKZ/OehCLO9EzgtHqjvJGedCRwMgeIGQKU+kGulTg4LF9TrwyYbFy3R+yo1Vi1wg+x
 L5CEq0PQe3DdZ/43QWfXSG4GV8UOuKXGuJHoNWd0=
Date: Thu, 6 Jun 2019 14:46:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v9 11/12] libnvdimm/pfn: Fix fsdax-mode namespace
 info-block zero-fields
Message-Id: <20190606144643.4f3363db9499ebbf8f76e62e@linux-foundation.org>
In-Reply-To: <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977193862.2443951.10284714500308539570.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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
Cc: mhocko@suse.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-mm@kvack.org, osalvador@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, 05 Jun 2019 14:58:58 -0700 Dan Williams <dan.j.williams@intel.com> wrote:

> At namespace creation time there is the potential for the "expected to
> be zero" fields of a 'pfn' info-block to be filled with indeterminate
> data. While the kernel buffer is zeroed on allocation it is immediately
> overwritten by nd_pfn_validate() filling it with the current contents of
> the on-media info-block location. For fields like, 'flags' and the
> 'padding' it potentially means that future implementations can not rely
> on those fields being zero.
> 
> In preparation to stop using the 'start_pad' and 'end_trunc' fields for
> section alignment, arrange for fields that are not explicitly
> initialized to be guaranteed zero. Bump the minor version to indicate it
> is safe to assume the 'padding' and 'flags' are zero. Otherwise, this
> corruption is expected to benign since all other critical fields are
> explicitly initialized.
> 
> Fixes: 32ab0a3f5170 ("libnvdimm, pmem: 'struct page' for pmem")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

The cc:stable in [11/12] seems odd.  Is this independent of the other
patches?  If so, shouldn't it be a standalone thing which can be
prioritized?

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
