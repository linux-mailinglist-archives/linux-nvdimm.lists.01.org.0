Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3A133867
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jan 2020 02:20:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 910FB10097E1B;
	Tue,  7 Jan 2020 17:23:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.65; helo=mga03.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31D4510097E18
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 17:23:34 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 17:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600";
   d="scan'208";a="271694238"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2020 17:20:15 -0800
Date: Tue, 7 Jan 2020 17:20:15 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Barret Rhoden <brho@google.com>
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20200108012014.GF16987@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
 <e012696f-f13e-5af1-2b14-084607d69bfa@google.com>
 <20200107190522.GA16987@linux.intel.com>
 <08a36944-ad5a-ca49-99b3-d3908ce0658b@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <08a36944-ad5a-ca49-99b3-d3908ce0658b@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: HCP4PWB6MWIS7NG7ZASWRX4F5XMYFOIU
X-Message-ID-Hash: HCP4PWB6MWIS7NG7ZASWRX4F5XMYFOIU
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HCP4PWB6MWIS7NG7ZASWRX4F5XMYFOIU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 07, 2020 at 02:19:06PM -0500, Barret Rhoden wrote:
> On 1/7/20 2:05 PM, Sean Christopherson wrote:
> >Hopefully you haven't put too much effort into the rework, because I want
> >to commandeer the proposed changes and use them as the basis for a more
> >aggressive overhaul of KVM's hugepage handling.  Ironically, there's a bug
> >in KVM's THP handling that I _think_ can be avoided by using the DAX
> >approach of walking the host PTEs.
> >
> >I'm in the process of testing, hopefully I'll get a series sent out later
> >today.  If not, I should at least be able to provide an update.
> 
> Nice timing.  I was just about to get back to this, so I haven't put any
> time in yet.  =)
> 
> Please CC me, and I'll try your patches out on my end.

Will do.  Barring last minute hiccups, the code is ready, just need to
finish off a few changelogs.  Should get it out early tomorrow.

One question that may help avoid some churn: are huge DAX pages not
tracked as compound pages?  The comment from your/this patch is pretty
unequivocal, but I wanted to double check that they will really return
false for PageCompound(), as opposed to only returning false for
PageTransCompoundMap().

	/*
	 * DAX pages do not use compound pages.  ...
	 */

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
