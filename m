Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED7F2EA0D2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 00:32:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4B569100EC1EB;
	Mon,  4 Jan 2021 15:32:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.79; helo=aserp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55C34100EC1E8
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 15:32:03 -0800 (PST)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NStH3180275;
	Mon, 4 Jan 2021 23:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vVs+eAl8TRmQb1+nM0NLAnLj6aIMlFfEaNzxzE8Ezkk=;
 b=WQgb+pNNwg38aDMDNPrvVtZr1vKf9l3QiM15noDQGizT5uAMZzhL4aDFBJ2aOmwp52Lc
 q1a+d8V+ZQiyTSnBL3n1665kXPBZ6SO0YCzHH3mSqoy6cptWqkz606ENRwrQJtIawyI2
 qi+xpdVXjs+cUsU60m/IlWmpr730sJgXlxgPANR5WWmyhD/Aju/ReXb/2AKyQQJwSEwt
 1LkgiRe6cQ7G+hDYsuEzwx5BpBjXIgJ/1GPN+mD351UGVG1dFBLMYsWK22vfmN4Xh5i3
 oCXECrhx3bHN5zL4YmZ0CoCA+NXGV/32ybTpCvcU0TjlGJX10ZAaTnA/Dan/9Qe9jhA6 Mg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 35tebappsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 04 Jan 2021 23:31:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104NVPbY056531;
	Mon, 4 Jan 2021 23:31:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 35v1f7xgfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Jan 2021 23:31:49 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104NM1eH026653;
	Mon, 4 Jan 2021 23:22:01 GMT
Received: from localhost (/10.159.152.204)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 04 Jan 2021 15:22:00 -0800
Date: Mon, 4 Jan 2021 15:21:59 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 09/10] xfs: Implement ->corrupted_range() for XFS
Message-ID: <20210104232159.GQ6918@magnolia>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-10-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-10-ruansy.fnst@cn.fujitsu.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040142
Message-ID-Hash: J42SWQZ2ZCGBZFQL7JBRYCTYTAXSLNFN
X-Message-ID-Hash: J42SWQZ2ZCGBZFQL7JBRYCTYTAXSLNFN
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J42SWQZ2ZCGBZFQL7JBRYCTYTAXSLNFN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 31, 2020 at 12:56:00AM +0800, Shiyang Ruan wrote:
> This function is used to handle errors which may cause data lost in
> filesystem.  Such as memory failure in fsdax mode.
> 
> In XFS, it requires "rmapbt" feature in order to query for files or
> metadata which associated to the corrupted data.  Then we could call fs
> recover functions to try to repair the corrupted data.(did not
> implemented in this patchset)
> 
> After that, the memory failure also needs to notify the processes who
> are using those files.
> 
> Only support data device.  Realtime device is not supported for now.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/xfs/xfs_fsops.c |   5 +++
>  fs/xfs/xfs_mount.h |   1 +
>  fs/xfs/xfs_super.c | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 
> diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
> index ef1d5bb88b93..0a2038875d32 100644
> --- a/fs/xfs/xfs_fsops.c
> +++ b/fs/xfs/xfs_fsops.c
> @@ -501,6 +501,11 @@ xfs_do_force_shutdown(
>  "Corruption of in-memory data detected.  Shutting down filesystem");
>  		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
>  			xfs_stack_trace();
> +	} else if (flags & SHUTDOWN_CORRUPT_META) {
> +		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_CORRUPT,
> +"Corruption of on-disk metadata detected.  Shutting down filesystem");
> +		if (XFS_ERRLEVEL_HIGH <= xfs_error_level)
> +			xfs_stack_trace();
>  	} else if (logerror) {
>  		xfs_alert_tag(mp, XFS_PTAG_SHUTDOWN_LOGERROR,
>  			"Log I/O Error Detected. Shutting down filesystem");
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index dfa429b77ee2..8f0df67ffcc1 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -274,6 +274,7 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, int flags, char *fname,
>  #define SHUTDOWN_LOG_IO_ERROR	0x0002	/* write attempt to the log failed */
>  #define SHUTDOWN_FORCE_UMOUNT	0x0004	/* shutdown from a forced unmount */
>  #define SHUTDOWN_CORRUPT_INCORE	0x0008	/* corrupt in-memory data structures */
> +#define SHUTDOWN_CORRUPT_META	0x0010  /* corrupt metadata on device */
>  
>  /*
>   * Flags for xfs_mountfs
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index e3e229e52512..cbcad419bb9e 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -35,6 +35,11 @@
>  #include "xfs_refcount_item.h"
>  #include "xfs_bmap_item.h"
>  #include "xfs_reflink.h"
> +#include "xfs_alloc.h"
> +#include "xfs_rmap.h"
> +#include "xfs_rmap_btree.h"
> +#include "xfs_rtalloc.h"
> +#include "xfs_bit.h"
>  
>  #include <linux/magic.h>
>  #include <linux/fs_context.h>
> @@ -1103,6 +1108,107 @@ xfs_fs_free_cached_objects(
>  	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
>  }
>  
> +static int
> +xfs_corrupt_helper(
> +	struct xfs_btree_cur		*cur,
> +	struct xfs_rmap_irec		*rec,
> +	void				*data)
> +{
> +	struct xfs_inode		*ip;
> +	struct address_space		*mapping;
> +	int				rc = 0;
> +	int				*flags = data;
> +
> +	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
> +	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
> +		// TODO check and try to fix metadata
> +		rc = -EFSCORRUPTED;
> +	} else {
> +		/*
> +		 * Get files that incore, filter out others that are not in use.
> +		 */
> +		rc = xfs_iget(cur->bc_mp, cur->bc_tp, rec->rm_owner,
> +			      XFS_IGET_INCORE, 0, &ip);
> +		if (rc || !ip)
> +			return rc;
> +		if (!VFS_I(ip)->i_mapping)
> +			goto out;
> +
> +		mapping = VFS_I(ip)->i_mapping;
> +		if (IS_DAX(VFS_I(ip)))
> +			rc = mf_dax_mapping_kill_procs(mapping, rec->rm_offset,
> +						       *flags);
> +		else
> +			mapping_set_error(mapping, -EFSCORRUPTED);

Hm.  I don't know if EFSCORRUPTED is the right error code for corrupt
file data, since we (so far) have only used it for corrupt metadata.

> +
> +		// TODO try to fix data
> +out:
> +		xfs_irele(ip);
> +	}
> +
> +	return rc;
> +}
> +
> +static int
> +xfs_fs_corrupted_range(
> +	struct super_block	*sb,
> +	struct block_device	*bdev,
> +	loff_t			offset,
> +	size_t			len,
> +	void			*data)
> +{
> +	struct xfs_mount	*mp = XFS_M(sb);
> +	struct xfs_trans	*tp = NULL;
> +	struct xfs_btree_cur	*cur = NULL;
> +	struct xfs_rmap_irec	rmap_low, rmap_high;
> +	struct xfs_buf		*agf_bp = NULL;
> +	xfs_fsblock_t		fsbno = XFS_B_TO_FSB(mp, offset);
> +	xfs_filblks_t		bcnt = XFS_B_TO_FSB(mp, len);
> +	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> +	xfs_agblock_t		agbno = XFS_FSB_TO_AGBNO(mp, fsbno);
> +	int			error = 0;
> +
> +	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev == bdev) {
> +		xfs_warn(mp, "corrupted_range support not available for realtime device!");
> +		return 0;
> +	}
> +	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_bdev == bdev &&
> +	    mp->m_logdev_targp != mp->m_ddev_targp) {
> +		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> +		return 0;
> +	}
> +
> +	if (!xfs_sb_version_hasrmapbt(&mp->m_sb)) {
> +		xfs_warn(mp, "corrupted_range needs rmapbt enabled!");
> +		return 0;
> +	}
> +
> +	error = xfs_trans_alloc_empty(mp, &tp);
> +	if (error)
> +		return error;
> +
> +	error = xfs_alloc_read_agf(mp, tp, agno, 0, &agf_bp);
> +	if (error)
> +		return error;
> +
> +	cur = xfs_rmapbt_init_cursor(mp, tp, agf_bp, agno);
> +
> +	/* Construct a range for rmap query */
> +	memset(&rmap_low, 0, sizeof(rmap_low));
> +	memset(&rmap_high, 0xFF, sizeof(rmap_high));
> +	rmap_low.rm_startblock = rmap_high.rm_startblock = agbno;
> +	rmap_low.rm_blockcount = rmap_high.rm_blockcount = bcnt;
> +
> +	error = xfs_rmap_query_range(cur, &rmap_low, &rmap_high, xfs_corrupt_helper, data);
> +	if (error == -EFSCORRUPTED)
> +		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_META);
> +
> +	xfs_btree_del_cursor(cur, error);
> +	xfs_trans_brelse(tp, agf_bp);

The transaction needs to be committed (or cancelled) here, or else it
leaks.

--D

> +	return error;
> +}
> +
>  static const struct super_operations xfs_super_operations = {
>  	.alloc_inode		= xfs_fs_alloc_inode,
>  	.destroy_inode		= xfs_fs_destroy_inode,
> @@ -1116,6 +1222,7 @@ static const struct super_operations xfs_super_operations = {
>  	.show_options		= xfs_fs_show_options,
>  	.nr_cached_objects	= xfs_fs_nr_cached_objects,
>  	.free_cached_objects	= xfs_fs_free_cached_objects,
> +	.corrupted_range	= xfs_fs_corrupted_range,
>  };
>  
>  static int
> -- 
> 2.29.2
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
