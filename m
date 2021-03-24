Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3B9347FA0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 18:39:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 60FDC100EB331;
	Wed, 24 Mar 2021 10:39:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 440AE100EB32D
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 10:39:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1520C68BEB; Wed, 24 Mar 2021 18:39:36 +0100 (CET)
Date: Wed, 24 Mar 2021 18:39:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Message-ID: <20210324173935.GB12770@lst.de>
References: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com> <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com> <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com> <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com> <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com> <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com> <20210324074751.GA1630@lst.de> <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: UIBOL7PMCKZHKNLW4P473V73NBZBGEI6
X-Message-ID-Hash: UIBOL7PMCKZHKNLW4P473V73NBZBGEI6
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UIBOL7PMCKZHKNLW4P473V73NBZBGEI6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 24, 2021 at 09:37:01AM -0700, Dan Williams wrote:
> > Eww.  As I said I think the right way is that the file system (or
> > other consumer) can register a set of callbacks for opening the device.
> 
> How does that solve the problem of the driver being notified of all
> pfn failure events?

Ok, I probably just showed I need to spend more time looking at
your proposal vs the actual code..

Don't we have a proper way how one of the nvdimm layers own a
spefific memory range and call directly into that instead of through
a notifier?

> Today pmem only finds out about the ones that are
> notified via native x86 machine check error handling via a notifier
> (yes "firmware-first" error handling fails to do the right thing for
> the pmem driver),

Did any kind of firmware-first error handling ever get anything
right?  I wish people would have learned that by now.

> or the ones that are eventually reported via address
> range scrub, but only for the nvdimms that implement range scrubbing.
> memory_failure() seems a reasonable catch all point to route pfn
> failure events, in an arch independent way, to interested drivers.

Yeah.

> I'm fine swapping out dax_device blocking_notiier chains for your
> proposal, but that does not address all the proposed reworks in my
> list which are:
> 
> - delete "drivers/acpi/nfit/mce.c"
> 
> - teach memory_failure() to be able to communicate range failure
> 
> - enable memory_failure() to defer to a filesystem that can say
> "critical metadata is impacted, no point in trying to do file-by-file
> isolation, bring the whole fs down".

This all sounds sensible.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
