Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BD42975C3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 23 Oct 2020 19:28:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E49971633C8FF;
	Fri, 23 Oct 2020 10:28:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3A72A1633C8FE
	for <linux-nvdimm@lists.01.org>; Fri, 23 Oct 2020 10:28:32 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A965DAB95;
	Fri, 23 Oct 2020 17:28:30 +0000 (UTC)
Date: Fri, 23 Oct 2020 19:28:29 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: vaibhav@linux.ibm.com
Subject: Re: Feedback requested: Exposing NVDIMM performance statistics in a
 generic way
Message-ID: <20201023192829.3ee3c1a7@naga.suse.cz>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
In-Reply-To: <87r1v3lwcn.fsf@linux.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: MBTUMF7JL7ZBM75P3B3GECSLQWR3QZEH
X-Message-ID-Hash: MBTUMF7JL7ZBM75P3B3GECSLQWR3QZEH
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, aneesh.kumar@linux.ibm.com, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MBTUMF7JL7ZBM75P3B3GECSLQWR3QZEH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Thu, May 28, 2020 at 11:59 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Thanks for this taking time to look into this Dan,
>
> Agree with the points you have made earlier that I am summarizing below:
>
> * This is better done in ndctl rather than ipmctl.
> * Should only expose general performance metrics and not performance
>   counters. Performance counter should be exposed via perf
> * Vendor specific metrics to be separated from generic performance
>   metrics.
>
> One way to split generic and vendor specific metrics might be to report
> generic performance metrics together with dimm health metrics such as
> "temprature_celsius" or "spares_percentage" that are already reported in
> by dimm health output.
>
> Vendor specific performance metrics can be reported as a seperate object
> in the json output. Something similar to output below:
>
> # ndctl list -DH --stats --vendor-stats
> [
>   {
>     "dev":"nmem0",
>     "health":{
>       "health_state":"ok",
>       "shutdown_state":"clean",
>       "temperature_celsius":48.00,
>       "spares_percentage":10,
>
>       /* Generic performance metrics/stats */
>       "TotalMediaReads": 18929,
>       "TotalMediaWrites": 0,
>       ....
>     }
>
>     /* Vendor specific stats for the dimm */
>     "vendor-stats": {
>     "Controller Reset Count":10
>     "Controller Reset Elapsed Time": 3600
>     "Power-on Seconds": 3600

How do you tell generic from vendor-specific stats, though?

Controller reset count and power-on time may not be reported by some
controllers but sound pretty generic.

Even if you declare that the stats reported by all controllers
available at this moment are generic a later one may not report some of
these 'generic' statistics, or report them in different way/units, or
may simply not report anything at all for some technical reason.

Kernels that do not have this feature will not report anything at all
either.

Thanks

Michal
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
