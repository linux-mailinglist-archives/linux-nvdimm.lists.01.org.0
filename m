Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 483201E797B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 11:33:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4CDC612313CDE;
	Fri, 29 May 2020 02:28:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A43511230F478
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 02:28:51 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C6692AE69;
	Fri, 29 May 2020 09:33:12 +0000 (UTC)
Date: Fri, 29 May 2020 11:33:10 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: jack@suse.de
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
Message-ID: <20200529093310.GL25173@kitsune.suse.cz>
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: UZJKBYO6EYKUFX3LNJE5XQRZ4VE5T7HV
X-Message-ID-Hash: UZJKBYO6EYKUFX3LNJE5XQRZ4VE5T7HV
X-MailFrom: msuchanek@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UZJKBYO6EYKUFX3LNJE5XQRZ4VE5T7HV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding Jan

On Fri, May 29, 2020 at 11:11:39AM +0530, Aneesh Kumar K.V wrote:
> With POWER10, architecture is adding new pmem flush and sync instructions.
> The kernel should prevent the usage of MAP_SYNC if applications are not using
> the new instructions on newer hardware.
> 
> This patch adds a prctl option MAP_SYNC_ENABLE that can be used to enable
> the usage of MAP_SYNC. The kernel config option is added to allow the user
> to control whether MAP_SYNC should be enabled by default or not.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/sched/coredump.h | 13 ++++++++++---
>  include/uapi/linux/prctl.h     |  3 +++
>  kernel/fork.c                  |  8 +++++++-
>  kernel/sys.c                   | 18 ++++++++++++++++++
>  mm/Kconfig                     |  3 +++
>  mm/mmap.c                      |  4 ++++
>  6 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index ecdc6542070f..9ba6b3d5f991 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -72,9 +72,16 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
>  #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>  #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_MAP_SYNC	27	/* disable THP for all VMAs */
> +#define MMF_DISABLE_THP_MASK		(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_MAP_SYNC_MASK	(1 << MMF_DISABLE_MAP_SYNC)
>  
> -#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> -				 MMF_DISABLE_THP_MASK)
> +#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK | \
> +			MMF_DISABLE_THP_MASK | MMF_DISABLE_MAP_SYNC_MASK)
> +
> +static inline bool map_sync_enabled(struct mm_struct *mm)
> +{
> +	return !(mm->flags & MMF_DISABLE_MAP_SYNC_MASK);
> +}
>  
>  #endif /* _LINUX_SCHED_COREDUMP_H */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..ee4cde32d5cf 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,7 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +#define PR_SET_MAP_SYNC_ENABLE		59
> +#define PR_GET_MAP_SYNC_ENABLE		60
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8c700f881d92..d5a9a363e81e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLOCK(mmlist_lock);
>  
>  static unsigned long default_dump_filter = MMF_DUMP_FILTER_DEFAULT;
>  
> +#ifdef CONFIG_ARCH_MAP_SYNC_DISABLE
> +unsigned long default_map_sync_mask = MMF_DISABLE_MAP_SYNC_MASK;
> +#else
> +unsigned long default_map_sync_mask = 0;
> +#endif
> +
>  static int __init coredump_filter_setup(char *s)
>  {
>  	default_dump_filter =
> @@ -1039,7 +1045,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  		mm->flags = current->mm->flags & MMF_INIT_MASK;
>  		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
>  	} else {
> -		mm->flags = default_dump_filter;
> +		mm->flags = default_dump_filter | default_map_sync_mask;
>  		mm->def_flags = 0;
>  	}
>  
> diff --git a/kernel/sys.c b/kernel/sys.c
> index d325f3ab624a..f6127cf4128b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2450,6 +2450,24 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
>  		up_write(&me->mm->mmap_sem);
>  		break;
> +
> +	case PR_GET_MAP_SYNC_ENABLE:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = !test_bit(MMF_DISABLE_MAP_SYNC, &me->mm->flags);
> +		break;
> +	case PR_SET_MAP_SYNC_ENABLE:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		if (down_write_killable(&me->mm->mmap_sem))
> +			return -EINTR;
> +		if (arg2)
> +			clear_bit(MMF_DISABLE_MAP_SYNC, &me->mm->flags);
> +		else
> +			set_bit(MMF_DISABLE_MAP_SYNC, &me->mm->flags);
> +		up_write(&me->mm->mmap_sem);
> +		break;
> +
>  	case PR_MPX_ENABLE_MANAGEMENT:
>  	case PR_MPX_DISABLE_MANAGEMENT:
>  		/* No longer implemented: */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index c1acc34c1c35..38fd7cfbfca8 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -867,4 +867,7 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>  
> +config ARCH_MAP_SYNC_DISABLE
> +	bool
> +
>  endmenu
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f609e9ec4a25..613e5894f178 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1464,6 +1464,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		case MAP_SHARED_VALIDATE:
>  			if (flags & ~flags_mask)
>  				return -EOPNOTSUPP;
> +
> +			if ((flags & MAP_SYNC)  && !map_sync_enabled(mm))
> +				return -EOPNOTSUPP;
> +
>  			if (prot & PROT_WRITE) {
>  				if (!(file->f_mode & FMODE_WRITE))
>  					return -EACCES;
> -- 
> 2.26.2
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
