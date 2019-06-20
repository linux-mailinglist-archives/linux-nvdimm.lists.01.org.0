Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674634C789
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Jun 2019 08:34:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF8F12129DB88;
	Wed, 19 Jun 2019 23:34:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 284A22129DB83
 for <linux-nvdimm@lists.01.org>; Wed, 19 Jun 2019 23:34:10 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 515C62070B;
 Thu, 20 Jun 2019 06:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561012450;
 bh=Ho986ZwEwN6lSqW02CRO5TRKTGH2igmUfY7a/ULtRRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lFM3+3jhB60zvG/6yB5IE5B3Rx+VKwvPqzhLzTvAMHSgLqGN5c7UT/x7JJ1TuJGVF
 lVevF4s7TKlP8/Hj+yX54QMnBdPlf/MMKzNcCIdDbj9TeGMDC6DOu+5ILxmtYZrzRg
 godWZUUe0caVwlu6le/5vxZ5bW96eLKozu4FLnhk=
Date: Thu, 20 Jun 2019 08:34:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 6/6] driver-core, libnvdimm: Let device subsystems add
 local lockdep coverage
Message-ID: <20190620063408.GA4768@kroah.com>
References: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156029557585.419799.11741877483838451695.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4h8QZBAC4kY3=mJVq0J8-W3aTLoT6h2b0WXFtymzToH-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4h8QZBAC4kY3=mJVq0J8-W3aTLoT6h2b0WXFtymzToH-Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 19, 2019 at 03:21:58PM -0700, Dan Williams wrote:
> On Tue, Jun 11, 2019 at 4:40 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > For good reason, the standard device_lock() is marked
> > lockdep_set_novalidate_class() because there is simply no sane way to
> > describe the myriad ways the device_lock() ordered with other locks.
> > However, that leaves subsystems that know their own local device_lock()
> > ordering rules to find lock ordering mistakes manually. Instead,
> > introduce an optional / additional lockdep-enabled lock that a subsystem
> > can acquire in all the same paths that the device_lock() is acquired.
> >
> > A conversion of the NFIT driver and NVDIMM subsystem to a
> > lockdep-validate device_lock() scheme is included. The
> > debug_nvdimm_lock() implementation implements the correct lock-class and
> > stacking order for the libnvdimm device topology hierarchy.
> 
> Greg, Peter,
> 
> Any thoughts on carrying this debug hack upstream? The idea being that
> it's impossible to enable lockdep for the device_lock() globally, but
> a constrained usage of the proposed lockdep_mutex has proven enough to
> flush out device_lock deadlocks from libnvdimm.
> 
> It appears one aspect that is missing from this patch proposal is a
> mechanism / convention to make sure that lockdep_mutex has constrained
> usage for a given kernel build, otherwise it's obviously just as
> problematic as device_lock(). Other concerns?

Yeah, it feels a bit hacky but it's really up to a subsystem to mess up
using it as much as anything else, so user beware :)

I don't object to it if it makes things easier for you to debug.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
