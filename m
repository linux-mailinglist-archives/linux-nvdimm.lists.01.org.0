Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79190397F3
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 Jun 2019 23:41:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6C19221290DFC;
	Fri,  7 Jun 2019 14:41:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=osalvador@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 16F6521275442
 for <linux-nvdimm@lists.01.org>; Fri,  7 Jun 2019 14:41:30 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 56294ABE9;
 Fri,  7 Jun 2019 21:41:29 +0000 (UTC)
Message-ID: <1559943687.3141.8.camel@suse.de>
Subject: Re: [PATCH v9 08/12] mm/sparsemem: Support sub-section hotplug
From: Oscar Salvador <osalvador@suse.de>
To: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 07 Jun 2019 23:41:27 +0200
In-Reply-To: <CAPcyv4hgmjUvA0+uMWYJibmgSWtoLw7zM-jFuP7eRdU2xyVxOw@mail.gmail.com>
References: <155977186863.2443951.9036044808311959913.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155977192280.2443951.13941265207662462739.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607083351.GA5342@linux>
 <CAPcyv4hgmjUvA0+uMWYJibmgSWtoLw7zM-jFuP7eRdU2xyVxOw@mail.gmail.com>
X-Mailer: Evolution 3.26.1 
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
Cc: Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, 2019-06-07 at 08:38 -0700, Dan Williams wrote:
> I don't know, but I can't imagine it would because it's much easier
> to
> do mem_map relative translations by simple PAGE_OFFSET arithmetic.

Yeah, I guess so.

> No worries, its a valid question. The bitmap dance is still valid it
> will just happen on section boundaries instead of subsection. If
> anything breaks that's beneficial additional testing that we got from
> the SPARSEMEM sub-case for the SPARSEMEM_VMEMMAP superset-case.
> That's
> the gain for keeping them unified, what's the practical gain from
> hiding this bit manipulation from the SPARSEMEM case?

It is just that I thought that we might benefit from not doing extra
work if not needed (bitmap dance) in SPARSEMEM case.
But given that 1) hot-add/hot-remove paths are not hot paths, it does
not really matter 2) and that having all cases unified in one function
make sense too, spreading the work in more functions might be sub-
optimal.
I guess I could justfiy it in case both activate/deactive functions
would look convulated, but it is not the case here.

I just took another look to check that I did not miss anything.
It looks quite nice and compact IMO:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
