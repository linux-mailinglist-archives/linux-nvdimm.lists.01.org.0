Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC2B02DE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 19:45:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A256C21962301;
	Wed, 11 Sep 2019 10:45:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=dave.jiang@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F3AEA202BDCAC
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 10:45:47 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 10:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,494,1559545200"; d="scan'208";a="200562914"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
 by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2019 10:45:38 -0700
Subject: Re: [PATCH v2 3/3] libnvdimm, MAINTAINERS: Maintainer Entry Profile
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 xsPuBE6TbysRDACKOBHZT4ez/3/idMBVQP+cMIJAWfTTLqbHVYLdHMHh4h6IXWLqWgc9AYTx
 /ajdOrBVGSK9kMuvqRi0iRO1QLOMUAIc2n/44vh/3Fe54QYfgbndeXhHZi7YEwjiTCbpQ336
 pS0rS2qQaA8GzFwu96OslLI05j9Ygaqy73qmuk3wxomIYiu9a97aN3oVv1RyTp6gJK1NWT3J
 On17P1yWUYPvY3KJtpVqnRLkLZeOIiOahgf9+qiYqPhKQI1Ycx4YhbqkNmDG1VqdMtEWREZO
 DpTti6oecydN37MW1Y+YSzWYDVLWfoLUr2tBveGCRLf/U2n+Tm2PlJR0IZq+BhtuIUVcRLQW
 vI+XenR8j3vHVNHs9UXW/FPB8Xb5fwY2bJniZ+B4G67nwelhMNWe7H9IcEaI7Eo32fZk+9fo
 x6GDAhdT0pEetwuhkmI0YYD7cQj1mEx1oEbzX2p/HRW9sHTSv0V2zKbkPvii3qgvCoDb1uLd
 4661UoSG0CYaAx8TwBxUqjsBAO9FXDhLHZJadyHmWp64xQGnNgBathuqoSsIWgQWBpfhDACA
 OYftX52Wp4qc3ZT06NPzGTV35xr4DVftxxUHiwzB/bzARfK8tdoW4A44gN3P03DAu+UqLoqm
 UP/e8gSLEjoaebjMu8c2iuOhk1ayHkDPc2gugTgLLBWPkhvIEV4rUV9C7TsgAAvNNDAe8X00
 Tu1m01A4ToLpYsNWEtM9ZRdKXSo6YS45DFRhel29ZRz24j4ZNIxN9Bee/fn7FrL4HgO01yH+
 QULDAtU87AkVoBdU5xBJVj7tGosuV+ia4UCWXjTzb+ERek2503OvNq4xqche3RMoZLsSHiOj
 5PjMNX4EA6pf5kRWdNutjmAsXrpZrnviWMPy+zHUzHIw/gaI00lHMjS0P99A7ay/9BjtsIBx
 lJZ09Kp6SE0EiZpFIxB5D0ji6rHu3Qblwq+WjM2+1pydVxqt2vt7+IZgEB4Qm6rml835UB89
 TTkMtiIXJ+hMC/hajIuFSah+CDkfagcrt1qiaVoEAs/1cCuAER+h5ClMnLZPPxNxphsqkXxn
 3MVJcMEL/iaMimP3oDXJoK3O+u3gC3p55A/LYZJ7hP9lHTT4MtgwmgBp9xPeVFWx3rwQOKix
 SPONHlkjfvn4dUHmaOmJyKgtt5htpox+XhBkuCZ5UWpQ40/GyVypWyBXtqNx/0IKByXy4QVm
 QjUL/U2DchYhW+2w8rghIhkuHX2YOdldyEvXkzN8ysGR31TDwshg600k4Q/UF/MouC2ZNeMa
 y8I0whHBFTwSjN5T1F9cvko4PsHNB3QH4M4tbArwn4RzSX6Hfxoq59ziyI4Et6sE5SyiVEZQ
 DhKZ8VU61uUaYHDdid8xKU4sV5IFCERIoIwieEAkITNvCdFtuXl9gugzld7IHbOTRaGy4M+M
 gOyAvSe5ysBrXhY+B0d+EYif1I8s4PbnkH2xehof++lQuy3+1TZcweSx1f/uF6d92ZDkvJzQ
 QbkicMLaPy0IS5XIMkkpD1zIO0jeaHcTm3uzB9k8N9y4tA2ELWVR/iFZigrtrwpIJtJLUieB
 89EOJLR6xbksSrFhQ80oRGF2ZSBKaWFuZyAoV29yaykgPGRhdmUuamlhbmdAaW50ZWwuY29t
 PsJ9BBMRCAAlAhsjBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCUZEwDwIZAQAKCRBkFcTx
 ZqO5Ps8HAP4kF/KAor80fNwT7osSHGG5rLFPR/Yc5V0QpqkU8DhZDgEAoStRa/a6Mtq3Ri1H
 B84kFIqSQ9ME5049k6k1K7wdXcvOwE0ETpNvKxAEANGHLx0q/R99wzbVdnRthIZttNQ6M4R8
 AAtEypE9JG3PLrEd9MUB5wf0fB/2Jypec3x935mRW3Zt1i+TrzjQDzMV5RyTtpWI7PwIh5IZ
 0h4OV2yQHFVViHi6lubCRypQYiMzTmEKua3LeBGvUR9vVmpPJZ/UP6VajKqywjPHYBwLAAMF
 A/9B/PdGc1sZHno0ezuwZO2J9BOsvASNUzamO9to5P9VHTA6UqRvyfXJpNxLF1HjT4ax7Xn4
 wGr6V1DCG3JYBmwIZjfinrLINKEK43L+sLbVVi8Mypc32HhNx/cPewROY2vPb4U7y3jhPBtt
 lt0ZMb75Lh7zY3TnGLOx1AEzmqwZSMJhBBgRCAAJBQJOk28rAhsMAAoJEGQVxPFmo7k+qiUB
 AKH0QWC+BBBn3pa9tzOz5hTrup+GIzf5TcuCsiAjISEqAPkBTGk5iiGrrHkxsz8VulDVpNxk
 o6nmKbYpUAltQObU2w==
Message-ID: <67708305-438f-8abe-66f1-f1daff5f8057@intel.com>
Date: Wed, 11 Sep 2019 10:45:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>



On 9/11/19 8:48 AM, Dan Williams wrote:
> Document the basic policies of the libnvdimm subsystem and provide a first
> example of a Maintainer Entry Profile for others to duplicate and edit.
> 
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  Documentation/nvdimm/maintainer-entry-profile.rst |   64 +++++++++++++++++++++
>  MAINTAINERS                                       |    4 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
> 
> diff --git a/Documentation/nvdimm/maintainer-entry-profile.rst b/Documentation/nvdimm/maintainer-entry-profile.rst
> new file mode 100644
> index 000000000000..c102950f2257
> --- /dev/null
> +++ b/Documentation/nvdimm/maintainer-entry-profile.rst
> @@ -0,0 +1,64 @@
> +LIBNVDIMM Maintainer Entry Profile
> +==================================
> +
> +Overview
> +--------
> +The libnvdimm subsystem manages persistent memory across multiple
> +architectures. The mailing list, is tracked by patchwork here:
> +https://patchwork.kernel.org/project/linux-nvdimm/list/
> +...and that instance is configured to give feedback to submitters on
> +patch acceptance and upstream merge. Patches are merged to either the
> +'libnvdimm-fixes', or 'libnvdimm-for-next' branch. Those branches are
> +available here:
> +https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/
> +
> +In general patches can be submitted against the latest -rc, however if
> +the incoming code change is dependent on other pending changes then the
> +patch should be based on the libnvdimm-for-next branch. However, since
> +persistent memory sits at the intersection of storage and memory there
> +are cases where patches are more suitable to be merged through a
> +Filesystem or the Memory Management tree. When in doubt copy the nvdimm
> +list and the maintainers will help route.
> +
> +Submissions will be exposed to the kbuild robot for compile regression
> +testing. It helps to get a success notification from that infrastructure
> +before submitting, but it is not required.
> +
> +
> +Submit Checklist Addendum
> +-------------------------
> +There are unit tests for the subsystem via the ndctl utility:
> +https://github.com/pmem/ndctl
> +Those tests need to be passed before the patches go upstream, but not
> +necessarily before initial posting. Contact the list if you need help
> +getting the test environment set up.
> +
> +
> +Key Cycle Dates
> +---------------
> +New submissions can be sent at any time, but if they intend to hit the
> +next merge window they should be sent before -rc4, and ideally
> +stabilized in the libnvdimm-for-next branch by -rc6. Of course if a
> +patch set requires more than 2 weeks of review -rc4 is already too late
> +and some patches may require multiple development cycles to review.
> +
> +
> +Coding Style Addendum
> +---------------------
> +libnvdimm expects multi-line statements to be double indented. I.e.
> +
> +        if (x...
> +                        && ...y) {
> +
> +
> +Review Cadence
> +--------------
> +In general, please wait up to one week before pinging for feedback. A
> +private mail reminder is preferred. Alternatively ask for other
> +developers that have Reviewed-by tags for libnvdimm changes to take a
> +look and offer their opinion.
> +
> +
> +Style Cleanup Patches
> +---------------------
> +Standalone style-cleanups are welcome.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5d111a86e61..2be1e18a368e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9185,6 +9185,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  L:	linux-nvdimm@lists.01.org
> +P:	Documentation/nvdimm/maintainer-entry-profile.rst
>  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
>  S:	Supported
>  F:	drivers/nvdimm/blk.c
> @@ -9195,6 +9196,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  L:	linux-nvdimm@lists.01.org
> +P:	Documentation/nvdimm/maintainer-entry-profile.rst
>  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
>  S:	Supported
>  F:	drivers/nvdimm/btt*
> @@ -9204,6 +9206,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  L:	linux-nvdimm@lists.01.org
> +P:	Documentation/nvdimm/maintainer-entry-profile.rst
>  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
>  S:	Supported
>  F:	drivers/nvdimm/pmem*
> @@ -9223,6 +9226,7 @@ M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Keith Busch <keith.busch@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
>  L:	linux-nvdimm@lists.01.org
> +P:	Documentation/nvdimm/maintainer-entry-profile.rst
>  Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
>  S:	Supported
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
