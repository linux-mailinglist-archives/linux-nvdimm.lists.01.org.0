Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA220DCC8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 22:28:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFFC3111F92BA;
	Mon, 29 Jun 2020 13:28:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9D6A7111F370F;
	Mon, 29 Jun 2020 13:27:59 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TKKu9r101973;
	Mon, 29 Jun 2020 16:27:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydmkm3y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 16:27:53 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TKKw8F102114;
	Mon, 29 Jun 2020 16:27:53 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ydmkm3xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 16:27:53 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TKJx5p005716;
	Mon, 29 Jun 2020 20:27:52 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by ppma04dal.us.ibm.com with ESMTP id 31wwr8qe5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 20:27:52 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TKRptM52363676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 20:27:51 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6464B28058;
	Mon, 29 Jun 2020 20:27:51 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70B32805C;
	Mon, 29 Jun 2020 20:27:47 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.39])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 20:27:47 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: kernel test robot <lkp@intel.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH v6 4/8] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
In-Reply-To: <202006300210.ADlNY4uw%lkp@intel.com>
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
 <202006300210.ADlNY4uw%lkp@intel.com>
Date: Tue, 30 Jun 2020 01:57:44 +0530
Message-ID: <87o8p1hb27.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-29_21:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290124
Message-ID-Hash: NEZBNXHFQI435TINHKKSTCVXEDJUABAA
X-Message-ID-Hash: NEZBNXHFQI435TINHKKSTCVXEDJUABAA
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: kbuild-all@lists.01.org, Jan Kara <jack@suse.cz>, msuchanek@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NEZBNXHFQI435TINHKKSTCVXEDJUABAA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

kernel test robot <lkp@intel.com> writes:

> Hi "Aneesh,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on linux-nvdimm/libnvdimm-for-next v5.8-rc3 next-20200629]
> [cannot apply to scottwood/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/Support-new-pmem-flush-and-sync-instructions-for-POWER/20200629-223649
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: arc-allyesconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/nvdimm/region_devs.c: In function 'generic_nvdimm_flush':
>>> drivers/nvdimm/region_devs.c:1215:2: error: implicit declaration of function 'arch_pmem_flush_barrier' [-Werror=implicit-function-declaration]
>     1215 |  arch_pmem_flush_barrier();
>          |  ^~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Ok let's move the back to include/linux/libnvdimm.h. Not all arch
include asm-generic/cacheflush.h

-aneesh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
