Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 312762675B8
	for <lists+linux-nvdimm@lfdr.de>; Sat, 12 Sep 2020 00:13:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6F99713E3D6F6;
	Fri, 11 Sep 2020 15:13:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4328413E3D6F4
	for <linux-nvdimm@lists.01.org>; Fri, 11 Sep 2020 15:13:12 -0700 (PDT)
IronPort-SDR: 19ZaSDV8xKUKrZTR/KayE7ti8NVSgZz+j3E5KJfCN8i3dlmXbfF7AYDzTBVCkUyJJHrYSU+dCH
 Wx9wywuI15ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="223050040"
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600";
   d="scan'208";a="223050040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 15:13:09 -0700
IronPort-SDR: eTBig4hSfL6lnTJoihIlCligSUTrY/gvwuRRv5l5i1orlyCrKapzQqaoAgppDDKttlAwqw58YC
 lpb7mf49z4Kw==
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600";
   d="scan'208";a="481488523"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 15:13:09 -0700
Date: Fri, 11 Sep 2020 15:13:08 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Fix warning triggered by
 perf_stats_show()
Message-ID: <20200911221308.GP1930795@iweiny-DESK2.sc.intel.com>
References: <20200910092212.107674-1-vaibhav@linux.ibm.com>
 <20200910155552.GN1930795@iweiny-DESK2.sc.intel.com>
 <878sdgqdrd.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878sdgqdrd.fsf@vajain21.in.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: BPF562MTHGJQXI4PMPO2L4MO6TLO6SXR
X-Message-ID-Hash: BPF562MTHGJQXI4PMPO2L4MO6TLO6SXR
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BPF562MTHGJQXI4PMPO2L4MO6TLO6SXR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Sep 12, 2020 at 01:36:46AM +0530, Vaibhav Jain wrote:
> Thanks for reviewing this patch Ira,
> 
> 
> Ira Weiny <ira.weiny@intel.com> writes:
> 
> > On Thu, Sep 10, 2020 at 02:52:12PM +0530, Vaibhav Jain wrote:
> >> A warning is reported by the kernel in case perf_stats_show() returns
> >> an error code. The warning is of the form below:
> >> 
> >>  papr_scm ibm,persistent-memory:ibm,pmemory@44100001:
> >>  	  Failed to query performance stats, Err:-10
> >>  dev_attr_show: perf_stats_show+0x0/0x1c0 [papr_scm] returned bad count
> >>  fill_read_buffer: dev_attr_show+0x0/0xb0 returned bad count
> >> 
> >> On investigation it looks like that the compiler is silently truncating the
> >> return value of drc_pmem_query_stats() from 'long' to 'int', since the
> >> variable used to store the return code 'rc' is an 'int'. This
> >> truncated value is then returned back as a 'ssize_t' back from
> >> perf_stats_show() to 'dev_attr_show()' which thinks of it as a large
> >> unsigned number and triggers this warning..
> >> 
> >> To fix this we update the type of variable 'rc' from 'int' to
> >> 'ssize_t' that prevents the compiler from truncating the return value
> >> of drc_pmem_query_stats() and returning correct signed value back from
> >> perf_stats_show().
> >> 
> >> Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance
> >>        stats from PHYP')
> >> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> >> ---
> >>  arch/powerpc/platforms/pseries/papr_scm.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> >> index a88a707a608aa..9f00b61676ab9 100644
> >> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> >> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> >> @@ -785,7 +785,8 @@ static int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc,
> >>  static ssize_t perf_stats_show(struct device *dev,
> >>  			       struct device_attribute *attr, char *buf)
> >>  {
> >> -	int index, rc;
> >> +	int index;
> >> +	ssize_t rc;
> >
> > I'm not sure this is really fixing everything here.
> 
> The issue is with the statement in perf_stats_show():
> 
> 'return rc ? rc : seq_buf_used(&s);'
> 
> The function seq_buf_used() returns an 'unsigned int' and with 'rc'
> typed as 'int', forces a promotion of the expression to 'unsigned int'
> which causes a loss of signedness of 'rc' and compiler silently
> assigns this unsigned value to the function return typed as 'signed
> long'.
> 
> Making 'rc', a 'signed long' forces a promotion of the expresion to
> 'signed long' which preserves the signedness of 'rc' and will also be
> compatible with the function return type.

Ok, ok, I read this all wrong.

FWIW I would also cast seq_buf_used() to ssize_t to show you know what you are
doing there.

> 
> >
> > drc_pmem_query_stats() can return negative errno's.  Why are those not checked
> > somewhere in perf_stats_show()?
> >
> For the specific invocation 'drc_pmem_query_stats(p, stats, 0)' we only
> expect return value 'rc <=0' with '0' indicating a successful fetch of
> nvdimm performance stats from hypervisor. Hence there are no explicit
> checks for negative error codes in the functions as all return values
> !=0 indicate an error.
> 
> 
> > It seems like all this fix is handling is a > 0 return value: 'ret[0]' from
> > line 289 in papr_scm.c...  Or something?
> No, in case the arg 'num_stats' is '0' and 'buff_stats != NULL' the
> variable 'size' is assigned a non-zero value hence that specific branch
> you mentioned  is never taken. Instead in case of success
> drc_pmem_query_stats() return '0' and in case of an error a negative
> error code is returned.
> 
> >
> > Worse yet drc_pmem_query_stats() is returning ssize_t which is a signed value.
> > Therefore, it should not be returning -errno.  I'm surprised the static
> > checkers did not catch that.
> Didnt quite get the assertion here. The function is marked to return
> 'ssize_t' because we can return both +ve for success and -ve values to
> indicate errors.

Sorry I was reading this as size_t and meant to say unsigned...  I was looking
at this too quickly.

> 
> >
> > I believe I caught similar errors with a patch series before which did not pay
> > attention to variable types.
> >
> > Please audit this code for these types of errors and ensure you are really
> > doing the correct thing when using the sysfs interface.  I'm pretty sure bad
> > things will eventually happen (if they are not already) if you return some
> > really big number to the sysfs core from *_show().
> I think this problem is different compared to what you had previously pointed
> to. The values returned from drc_pmem_query_stats() can be stored in an
> 'int' variable too, however it was the silent promotion of a signed type
> to unsigned type was what caused this specific issue.

Ok this makes more sense now.  Sorry about not looking more carefully.

But I still think matching up the return of seq_buf_used() is worth it.  I
don't particularly like depending on 'automatic' promotions which make
reviewing code harder like this.

And sorry if my email seemed harsh I did not mean it to be.  I just like when
types are more explicit because I feel like it can avoid issues like this.
(Specifically my confusion over the types...)

:-D

Thanks,
Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
