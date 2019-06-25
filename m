Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9285577F
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Jun 2019 21:00:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EB4A2129F03C;
	Tue, 25 Jun 2019 12:00:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=195.135.220.15; helo=mx1.suse.de;
 envelope-from=mhocko@kernel.org; receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 27F1C21188C5A
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 12:00:45 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6933EAD3A;
 Tue, 25 Jun 2019 19:00:44 +0000 (UTC)
Date: Tue, 25 Jun 2019 21:00:38 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
Message-ID: <20190625190038.GK11400@dhcp22.suse.cz>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
 <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de>
 <20190625150053.GJ11400@dhcp22.suse.cz>
 <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, nouveau@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Linux MM <linux-mm@kvack.org>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>,
 linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue 25-06-19 11:03:53, Dan Williams wrote:
> On Tue, Jun 25, 2019 at 8:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 25-06-19 09:23:17, Christoph Hellwig wrote:
> > > On Mon, Jun 24, 2019 at 11:24:48AM -0700, Dan Williams wrote:
> > > > I asked for this simply because it was not exported historically. In
> > > > general I want to establish explicit export-type criteria so the
> > > > community can spend less time debating when to use EXPORT_SYMBOL_GPL
> > > > [1].
> > > >
> > > > The thought in this instance is that it is not historically exported
> > > > to modules and it is safer from a maintenance perspective to start
> > > > with GPL-only for new symbols in case we don't want to maintain that
> > > > interface long-term for out-of-tree modules.
> > > >
> > > > Yes, we always reserve the right to remove / change interfaces
> > > > regardless of the export type, but history has shown that external
> > > > pressure to keep an interface stable (contrary to
> > > > Documentation/process/stable-api-nonsense.rst) tends to be less for
> > > > GPL-only exports.
> > >
> > > Fully agreed.  In the end the decision is with the MM maintainers,
> > > though, although I'd prefer to keep it as in this series.
> >
> > I am sorry but I am not really convinced by the above reasoning wrt. to
> > the allocator API and it has been a subject of many changes over time. I
> > do not remember a single case where we would be bending the allocator
> > API because of external modules and I am pretty sure we will push back
> > heavily if that was the case in the future.
> 
> This seems to say that you have no direct experience of dealing with
> changing symbols that that a prominent out-of-tree module needs? GPU
> drivers and the core-mm are on a path to increase their cooperation on
> memory management mechanisms over time, and symbol export changes for
> out-of-tree GPU drivers have been a significant source of friction in
> the past.

I have an experience e.g. to rework semantic of some gfp flags and that is
something that users usualy get wrong and never heard that an out of
tree code would insist on an old semantic and pushing us to the corner.

> > So in this particular case I would go with consistency and export the
> > same way we do with other functions. Also we do not want people to
> > reinvent this API and screw that like we have seen in other cases when
> > external modules try reimplement core functionality themselves.
> 
> Consistency is a weak argument when the cost to the upstream community
> is negligible. If the same functionality was available via another /
> already exported interface *that* would be an argument to maintain the
> existing export policy. "Consistency" in and of itself is not a
> precedent we can use more widely in default export-type decisions.
> 
> Effectively I'm arguing EXPORT_SYMBOL_GPL by default with a later
> decision to drop the _GPL. Similar to how we are careful to mark sysfs
> interfaces in Documentation/ABI/ that we are not fully committed to
> maintaining over time, or are otherwise so new that there is not yet a
> good read on whether they can be made permanent.

Documentation/process/stable-api-nonsense.rst
Really. If you want to play with GPL vs. EXPORT_SYMBOL else this is up
to you but I do not see any technical argument to make this particular
interface to the page allocator any different from all others that are
exported to modules.
-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
