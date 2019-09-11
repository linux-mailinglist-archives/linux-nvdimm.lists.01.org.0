Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EAB01CB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 18:40:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73CC721962301;
	Wed, 11 Sep 2019 09:40:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=martin.petersen@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 27BD0202B75FF
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 09:40:57 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BGd43i141111;
 Wed, 11 Sep 2019 16:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=VFpmtg3e/Aku2YtAZH7JPHfHkoiJ5a4bkDvJ9ThkoTE=;
 b=TYmke4Ji/D/b6KBrM2hrn51WRqdC3jm24SP9gFQbFVPBzaVGN1OUMpmlN/x3f9cbxUah
 UwuKdmdmrJPgwEfZ49zCoT7882qzSMSgELPStofE6RBdGqyc6o8CH8qL5QtJ+xrqw7Mk
 jtARwXhwDSlKkdfBVlqkHjfYlbpwDTzszi+8/XnsAOdxYBnwkZ62b2Jy8+XE+on1cpOM
 Zmq7ikHofxH8V2pQ6ljEG020SdsbD7XvnkcdwZwTWaosLvZ59T2A0GcA4ommatq8p4m6
 VugqSZrNbX2LOtAMReucIkbHZnJBVaGWOOZqdkZ3xd4a8eWueveA+MONBDyHmLnNHSs4 ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2uw1m93e2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 16:40:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BGcxQF078349;
 Wed, 11 Sep 2019 16:40:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2uxj88yyhr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 16:40:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BGeLaM031363;
 Wed, 11 Sep 2019 16:40:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 11 Sep 2019 09:40:20 -0700
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 0/3] Maintainer Entry Profiles
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Wed, 11 Sep 2019 12:40:16 -0400
In-Reply-To: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 (Dan Williams's message of "Wed, 11 Sep 2019 08:48:42 -0700")
Message-ID: <yq1o8zqeqhb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9377
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110154
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 ksummit-discuss@lists.linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Steve French <stfrench@microsoft.com>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dmitry Vyukov <dvyukov@google.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Hi Dan!

> At last years Plumbers Conference I proposed the Maintainer Entry
> Profile as a document that a maintainer can provide to set contributor
> expectations and provide fodder for a discussion between maintainers
> about the merits of different maintainer policies.

This looks pretty good to me.

After the Plumbers session last year I wrote this for SCSI based on a
prior version by Christoph. It's gone a bit stale but I'll update it to
match your template.

-- 
Martin K. Petersen	Oracle Linux Engineering



================================================
Linux SCSI Subsystem Patch Submission Guidelines
================================================
Martin K. Petersen <martin.petersen@oracle.com>


Release cycles and when to submit patches
=========================================
Each release cycle consists of:

* an 8 week submission window in which new core features and driver updates
  are added (scsi-queue)

* a 2 week merge window where it is customary not to post patches

* an 8 week stabilization window before final release where only bug fix
  patches are merged (scsi-fixes)

The submission/stabilization cycle may be shorter or longer than 8 weeks.
However, 8 weeks is the most common. Note that the code *submission window*
for the *next* kernel release overlaps with the *stabilization window* for the
*current* release:

+-------------+---------------------------------+-------------+-----------------
| Week  1 | 2 |  3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |  11  |  12  | 13 | 14 | .....
+-------------+---------------------------------+-------------+-----------------

+-------------+---------------------------------+-------------+
| 4.x merge   |    4.x stabilization window     | 4.x release |
| window      | rc1 rc2 rc3 rc4 rc5 rc6 rc7 rc8 |             |
+-------------+---------------------------------+-------------+
| Merge fixes | Big bug fixes.............small |   Stable    |
+-------------+---------------------------------+-------------+

              +---------------------------------+-------------+-----------------
              |    4.x+1 submission window      | 4.x+1 merge | 4.x+1 stabili-
              |                                 | window      | zation window
	      |                                 |             | rc1 rc2 rc3 ...
              +---------------------------------+-------------+-----------------
              | Big features/updates......small | Merge fixes | Big bug fixes..
              +---------------------------------+-------------+-----------------


Bug Fixes (4.x/scsi-fixes)
~~~~~~~~~~~~~~~~~~~~~~~~~~
During the two week merge window only fixes related to the merge process or
any critical functional deficiences discovered in the newly submitted code
will be merged.

During the subsequent stabilization window (rc cycle) the expectation is that
bug fix patches will become increasingly smaller and simpler. In other words:
There may be enough fallout from a merged driver update to justify sending a
5-patch remedial bug fix series during rc1/rc2. But at the end of the rc cycle
patches must be trivial one-liners.

After the final 4.x has been released, subsequent bug fixes will have to go
through the stable-kernel-rules.rst process.


New Features/Core Code Changes/Driver Updates (4.x+1/scsi-queue)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
New features for 4.x+1 should be sent to linux-scsi once the merge window is
over. I.e. once rc1 has been released. This ensures there is enough time to
undergo several review cycles before the submission window is closed.

At the end of the submission window (rc7/rc8) the expectation is that posted
patches will be small and fairly simple. No patch series.

Only critical patches are merged during the last (rc8) submission window week
to ensure sufficient zeroday test robot and linux-next coverage before sending
Linus the final pull request.


GIT Trees
=========
The SCSI patch submission trees can be found at:

    git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git

There are two concurrently active branches:

* 4.x/scsi-fixes for bug fixes to the current kernel rc

* 4.x+1/scsi-queue for new features and driver submissions for the next merge
  window

Both trees are usually based on Linus' 4.x-rc1.

Patches accepted into 4.x/scsi-fixes are typically submitted to Linus on a
weekly basis. Patches accepted into 4.x+1/scsi-queue are submitted at the
beginning of the merge window.

It is sometimes necessary to set up a separate 4.x+1/scsi-postmerge branch
which contains patches that depend on newly merged functionality in other
subsystems such as block or libata. The postmerge tree will be submitted to
Linus at the end of the merge window once all external dependencies have been
merged.


Patch Submission Process
========================
* All modifications to files under drivers/scsi should go through the SCSI
  tree.

* Read Documentation/process/submitting-patches.rst

* Send the patch or patch series to linux-scsi@vger.kernel.org

* Please make sure to Cc: the maintainer of the driver/component you are
  changing.

* Do not use custom To: and Cc: for individual patches. We want to see the
  whole series, even patches that potentially need to go through a different
  subsystem tree.

* Clearly indicate in the introductory letter which tree your submission is
  aimed at (scsi-fixes or scsi-queue). For individual patches you can indicate
  the desired tree below the --- separator.

* As a rule of thumb, any patch that goes through the scsi-fixes tree should
  have a stable tag unless it was a regression introduced in the current
  release.

* If the patch is a bugfix, please add:

    Fixes: 1234deadbeef ("Implement foobarbaz")
    Cc: <stable@vger.kernel.org> # v4.x+

  Where the v4.x indicates when commit 1234deadbeef was added to the kernel.

* When posting a revised patch or series, please manually add any Acked-by:,
  Reviewed-by:, or Tested-by: tags you may have received. Tags are only valid
  if the patch has not changed significantly. Rebasing without conflicts and
  typo fixes are generally OK and do not invalidate tags.

* Please CC: everyone that provided feedback when posting a revised
  patch or series.

* Custom patch number formatting often confuses patchwork. Please use git
  send-email -v instead of manually adding version numbers to individual
  patches. To send version 3 of a 10 patch series from the tip of the current
  tree you can do:

    git send-email -10 -v3 --compose --to=linux-scsi@vger.kernel.org

* Please put a change log after a --- separator in each revised patch. If the
  reason for the repost is global (i.e. a rebase) it is fine to put the
  changelog in the cover letter.


Patch Acceptance Criteria
=========================
* A patch needs two positive reviews (non-author Signed-off-by:, Acked-by:,
  Reviewed-by:, or Tested-by:).

* A Tested-by: is worth a thousand reviews.

* For drivers, at least one review is required from somebody outside the
  submitting company.

* Nobody has expressed any concerns about the patch on linux-scsi.

* The patch must apply cleanly. Use checkpatch and git send-email.

* The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
  and does not incur any zeroday test robot complaints.

* The patch must have a commit message that describes, comprehensively and in
  plain English, what the patch does.

  - Do not link to vendor bugzilla entries that require special access
    credentials. If there is anything of importance in bugzilla, put it in the
    commit message.

  - The bigger and more intrusive the patch, the bigger the accompanying
    commit message needs to be. "fooscsi: Add PCI id for model XYZ" is fine as
    a one-liner. "fooscsi: Rewrite DMA allocation and queue setup" most likely
    needs several paragraphs of discussion in the commit message.


Patch Review Communities
========================
While core SCSI folks generally perform a cursory review of every patch,
it is imperative that contributors with an interest in a particular
component form small communities that can review and test each other's
code. Such informal communities exist for several components or
sub-subsystems underneath the SCSI tree.

The best way to facilitate that your patch gets merged is to review patches
submitted by your fellow contributors and hope that they return the favor.


Patch Reviewer Responsibilities
===============================
If you provide feedback to a patch and the patch author addresses your
concerns in a new version, you are expected to respond to the new
patch. Many code contributions series fail to make forward progress
because reviewers do not ack or nack the changes they requested to be
made. Please make sure to always follow up when your review comments are
being addressed.


Driver Maintainer Responsibilities
==================================
Many of the actively developed SCSI subsystem drivers have one or more
official maintainers. These maintainers are often employed by the company
manufacturing the hardware in question and therefore have a vested interest in
making sure the driver is working correctly.

A driver maintainer must review and respond to *all submitted patches* to the
driver in a timely manner (5 business days). This includes:

* Proposed functional changes to the driver code

* Security fixes

* Trivial and typo patches

* Changes compelled by kernel interface changes

* Patches required to work correctly on architectures not commercially
  supported by the hardware manufacturer


Patch Acceptance Status
=======================
* Submitted patches and their current status can be viewed in patchwork at:

    https://patchwork.kernel.org/project/linux-scsi/list/

* If a submitted patch is not visible in patchwork, it does not exist. Please
  repost.

* If only a portion of a patch series visible in patchwork, the series does
  not exist. Please repost.

* Once a patch has been merged, you will receive a mail indicating into which
  tree it has been accepted.

* Patches that have not received sufficient Acked-by:, Reviewed-by:, or
  Tested-by: tags after two weeks get moved to "Deferred" status. This
  indicates that it necessary to resubmit the patches to the linux-scsi list.

* Patches submitted to linux-scsi but which need to go through another
  subsystem tree will be set to "Not Applicable" status.

* Patches which require rework will be set to "Changes Requested" status.

* Patches which have been obsoleted by a later version will be set to
  "Superceded" status.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
