Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E70FDB00C2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 18:03:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89C7521962301;
	Wed, 11 Sep 2019 09:03:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BB61421962301
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 09:03:10 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 09:03:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; d="scan'208";a="268788464"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 09:03:00 -0700
Subject: [PATCH v2 0/3] Maintainer Entry Profiles
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2019 08:48:42 -0700
Message-ID: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Olof Johansson <olof@lixom.net>, Steve French <stfrench@microsoft.com>,
 Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dmitry Vyukov <dvyukov@google.com>, "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since v1 [1]:
- Simplify the profile to a hopefully non-controversial set of
  attributes that address the most common sources of contributor
  confusion, or maintainer frustration.
- Rename "Subsystem Profile" to "Maintainer Entry Profile". Not every
  entry in MAINTAINERS represents a full subsystem. There may be driver
  local considerations to communicate to a submitter in addition to wider
  subsystem guidelines. 
- Delete the old P: tag in MAINTAINERS rather than convert to a new E:
  tag (Joe Perches).
[1]:  http://lore.kernel.org/r/154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com

---

At last years Plumbers Conference I proposed the Maintainer Entry
Profile as a document that a maintainer can provide to set contributor
expectations and provide fodder for a discussion between maintainers
about the merits of different maintainer policies.

For those that did not attend, the goal of the Maintainer Entry Profile,
and the Maintainer Handbook more generally, is to provide a desk
reference for maintainers both new and experienced. The session
introduction was:

    The first rule of kernel maintenance is that there are no hard and
    fast rules. That state of affairs is both a blessing and a curse. It
    has served the community well to be adaptable to the different
    people and different problem spaces that inhabit the kernel
    community. However, that variability also leads to inconsistent
    experiences for contributors, little to no guidance for new
    contributors, and unnecessary stress on current maintainers. There
    are quite a few of people who have been around long enough to make
    enough mistakes that they have gained some hard earned proficiency.
    However if the kernel community expects to keep growing it needs to
    be able both scale the maintainers it has and ramp new ones without
    necessarily let them make a decades worth of mistakes to learn the
    ropes. 

To be clear, the proposed document does not impose or suggest new
rules. Instead it provides an outlet to document the unwritten rules
and policies in effect for each subsystem, and that each subsystem
might decide differently for whatever reason.


---

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Maintainer Entry Profile
      Maintainer Handbook: Maintainer Entry Profile
      libnvdimm, MAINTAINERS: Maintainer Entry Profile


 Documentation/maintainer/index.rst                 |    1 
 .../maintainer/maintainer-entry-profile.rst        |   99 ++++++++++++++++++++
 Documentation/nvdimm/maintainer-entry-profile.rst  |   64 +++++++++++++
 MAINTAINERS                                        |   20 ++--
 4 files changed, 175 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
