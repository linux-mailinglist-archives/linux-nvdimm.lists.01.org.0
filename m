Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD36C4F6
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 04:28:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D666212C01EF;
	Wed, 17 Jul 2019 19:30:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C5DFF212C01E5
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 19:30:49 -0700 (PDT)
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1AB6320665;
 Thu, 18 Jul 2019 02:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563416901;
 bh=ARH8EQ0IsIwQgbUtuitrXQxkvZUjzgvXwHyXqAz7rHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pz+VlfMq7GcxdgJXU9N5Bt0VTh1JerW5UtHFzXt5vDZPDXN1vG0wz/+LmFWYVMv1n
 WzKHK0dNDnVyEIhFY3jYcjdsMJQg7NpmuoYxqg/aaZGsACaXVTYWh7Zv4kjttDcW1h
 no7J54cc9xiP6MpI2hGnquBvIwVHeYQn4usjVcuQ=
Date: Thu, 18 Jul 2019 11:28:19 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 7/7] driver-core, libnvdimm: Let device subsystems add
 local lockdep coverage
Message-ID: <20190718022819.GA15376@kroah.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156341210661.292348.7014034644265455704.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156341210661.292348.7014034644265455704.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-nvdimm@lists.01.org,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 17, 2019 at 06:08:26PM -0700, Dan Williams wrote:
> For good reason, the standard device_lock() is marked
> lockdep_set_novalidate_class() because there is simply no sane way to
> describe the myriad ways the device_lock() ordered with other locks.
> However, that leaves subsystems that know their own local device_lock()
> ordering rules to find lock ordering mistakes manually. Instead,
> introduce an optional / additional lockdep-enabled lock that a subsystem
> can acquire in all the same paths that the device_lock() is acquired.
> 
> A conversion of the NFIT driver and NVDIMM subsystem to a
> lockdep-validate device_lock() scheme is included. The
> debug_nvdimm_lock() implementation implements the correct lock-class and
> stacking order for the libnvdimm device topology hierarchy.
> 
> Yes, this is a hack, but hopefully it is a useful hack for other
> subsystems device_lock() debug sessions. Quoting Greg:
> 
>     "Yeah, it feels a bit hacky but it's really up to a subsystem to mess up
>      using it as much as anything else, so user beware :)
> 
>      I don't object to it if it makes things easier for you to debug."

Sure, apeal to my vanity and quote me in the changelog, it's as if you
are making it trivial for me to ack this...

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:)


_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
