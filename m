Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD9A4EB54
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 16:58:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7C4722129F108;
	Fri, 21 Jun 2019 07:58:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 351A521290DEE
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3dT8GgJ6+uQhH34e10+L7yEjvR1H493y6W8QxwGRYS0=; b=IciHtC1ApoWbUNoHP8hTutDrf
 o6gvUQ24Xt0J/bDrghCwt4cTzS188eaW79VxqY0BfbMmSloZAPNz+SSJ7lJwC1At/wwBlNnZMzGvE
 JI3kRdeSfQRJnLw93aYTxtNxEc88pjz1eFuKSrVFWWA9dYgBW3S2QHuF89ixFNoxdmCFa9evNZ71l
 bLbOKkFnBVE60MYg64lKrVu1HfeUjrlQHjDW2nCQQY0aK/NepvOgeU05EzOnC3ZAMsFFqVOTx03B9
 7rOmUhzubu7OkflA1YJR2Y2vXrp4aWmkmQskIwoNoAvTG4qZ/L9tz9pGkLltxg3c60n84ssoMa0Mi
 yBJMlDyDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1heKzO-0002EK-KP; Fri, 21 Jun 2019 14:58:06 +0000
Date: Fri, 21 Jun 2019 07:58:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/sparsemem: Cleanup 'section number' data types
Message-ID: <20190621145805.GN32656@bombadil.infradead.org>
References: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156107543656.1329419.11505835211949439815.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Michal Hocko <mhocko@suse.com>, linux-nvdimm@lists.01.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, akpm@linux-foundation.org,
 Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 20, 2019 at 05:06:46PM -0700, Dan Williams wrote:
> David points out that there is a mixture of 'int' and 'unsigned long'
> usage for section number data types. Update the memory hotplug path to
> use 'unsigned long' consistently for section numbers.

... because we're seriously considering the possibility that we'll need
more than 4 billion sections?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
