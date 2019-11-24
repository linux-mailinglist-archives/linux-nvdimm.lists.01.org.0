Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1418108504
	for <lists+linux-nvdimm@lfdr.de>; Sun, 24 Nov 2019 22:14:02 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFCD9100DC3D8;
	Sun, 24 Nov 2019 13:17:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.126; helo=mga18.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 019FF100DC3CD
	for <linux-nvdimm@lists.01.org>; Sun, 24 Nov 2019 13:17:21 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:13:58 -0800
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600";
   d="scan'208";a="198233077"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:13:58 -0800
Subject: [PATCH v3 0/3] Maintainer Entry Profiles
From: Dan Williams <dan.j.williams@intel.com>
To: corbet@lwn.net
Date: Sun, 24 Nov 2019 12:59:42 -0800
Message-ID: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: OLWAH2F7RPOB6ABSGCSOCH6W3R6BD6WC
X-Message-ID-Hash: OLWAH2F7RPOB6ABSGCSOCH6W3R6BD6WC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>, Joe Perches <joe@perches.com>, "Tobin C. Harding" <me@tobin.cc>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve French <stfrench@microsoft.com>, Olof Johansson <olof@lixom.net>, Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OLWAH2F7RPOB6ABSGCSOCH6W3R6BD6WC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v2 [1]:
- Drop any consideration for coding style concerns in the profile. It
  was a minor aspect of the proposal that generated the bulk of the
  feedback on v2. Lets make progress on the rest.

- Clarify that the "Submit Checklist Addendum" can also include details
  that submitters need to take into account before even beginning to
  craft a patch. This is in response to the RISC-V use case of
  declaring specification readiness as a patch gate, and is now also used
  by the libnvdimm subsystem to clarify details about ACPI NVDIMM Device
  Specific Method specifications. (Paul)

- Non-change from v2: Kees had asked for a common directory for all
  profiles to live, but Mauro noted that this could be handled later
  with some scripting to post-process the MAINTAINERS file, or otherwise
  converting MAINTAINERS to ReST.

- Clarify the cover letter to focus on the contributor focused
  Maintainer Entry Profiles, and defer discussion of a maintainer
  focused Handbook.

[1]: https://lore.kernel.org/ksummit-discuss/156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com/

---

At last years Plumbers Conference I proposed the Maintainer Entry
Profile as a document that a maintainer can provide to set contributor
expectations and provide fodder for a discussion between maintainers
about the merits of different maintainer policies.

For those that did not attend, the goal of the Maintainer Entry Profile
is to provide contributors documentation of patch submission
considerations that may vary by subsystem. The session introduction was:

    The first rule of kernel maintenance is that there are no hard and
    fast rules. That state of affairs is both a blessing and a curse. It
    has served the community well to be adaptable to the different
    people and different problem spaces that inhabit the kernel
    community. However, that variability also leads to inconsistent
    experiences for contributors, little to no guidance for new
    contributors, and unnecessary stress on current maintainers.

To be clear, the proposed document does not impose or suggest new rules.
Instead it provides an outlet to document the existing unwritten
policies in effect for a given subsystem.  Over time the hope is that
some of this variability can be up-levelled to new global process
policy, but in the meantime it provides relief for communicating the
guidelines that are being imposed on contributors.

---

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Maintainer Entry Profile
      Maintainer Handbook: Maintainer Entry Profile
      libnvdimm, MAINTAINERS: Maintainer Entry Profile


 Documentation/maintainer/index.rst                 |    1 
 .../maintainer/maintainer-entry-profile.rst        |   87 ++++++++++++++++++++
 Documentation/nvdimm/maintainer-entry-profile.rst  |   59 ++++++++++++++
 MAINTAINERS                                        |   20 +++--
 4 files changed, 158 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
